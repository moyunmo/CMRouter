//
//  CMRouter.m
//  CMRouter
//
//  Created by Moyun on 2017/8/20.
//  Copyright © 2017年 Cmall. All rights reserved.
//

#import "CMRouter.h"
#import <objc/runtime.h>

static NSMutableArray<Class> *CMModuleClasses;

void CMRegisterModule(Class);
void CMRegisterModule(Class moduleClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CMModuleClasses = [NSMutableArray new];
    });
    [CMModuleClasses addObject:moduleClass];
}

NSString *CMModuleNameForClass(Class cls)
{
    NSString *name = [cls moduleName];
    if (name.length == 0) {
        name = NSStringFromClass(cls);
    }
    return name;
}

@interface CMRouter ()

@property (strong, nonatomic) NSMutableDictionary *routers;

@end

@implementation CMRouter

#pragma mark - Public Method

+ (CMRouter *)sharedInstance
{
    static CMRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CMRouter alloc] init];
    });
    return instance;
}

- (void)setUpMoudles
{
    for (Class cls in CMModuleClasses) {
        @autoreleasepool{
            NSString *name = CMModuleNameForClass(cls);
            [self registerRoutersForRouter:name class:cls];
        }
    }
}

- (UIViewController *)controllerWithURL:(NSString *)URL
{
    return [self controllerWithURL:URL userInfo:nil];
}

- (UIViewController *)controllerWithURL:(NSString *)URL userInfo:(NSDictionary *)userInfo
{
    return [self controllerWithURL:URL userInfo:userInfo complete:NULL];
}

- (UIViewController *)controllerWithURL:(NSString *)URL
                               userInfo:(NSDictionary *)userInfo
                               complete:(CMRouterCallBack)complete
{
    NSDictionary *params = [self paramsInRouter:URL userInfo:userInfo complete:complete];
    if (!params) {
        return nil;
    }
    Class controllerClass = params[@"controller"];
    UIViewController *viewController = [[controllerClass alloc] init];
    if ([viewController respondsToSelector:@selector(setRouterParamater:)]) {
        [viewController performSelector:@selector(setRouterParamater:) withObject:[params copy]];
    }
    if (complete) {
        if ([viewController respondsToSelector:@selector(setRouterCallBack:)]) {
            [viewController performSelector:@selector(setRouterCallBack:) withObject:complete];
        }
    }
    return viewController;
}

+ (BOOL)canRouter:(NSString *)router
{
    NSDictionary *params = [[CMRouter sharedInstance] paramsInRouter:router userInfo:nil complete:NULL];
    return [params valueForKey:@"controller"];
}

#pragma mark - Private

- (NSDictionary *)paramsInRouter:(NSString *)router userInfo:(NSDictionary *)userInfo complete:(CMRouterCallBack)complete
{
    if (router.length < 1) {
        NSAssert(NO, @"router must be setted");
        return nil;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *routeString = [self filterAppSchemeWithRouter:router];
    [param setObject:routeString forKey:@"router"];
    NSMutableDictionary *subRoutes = self.routers;
    NSArray *pathComponents = [self pathComponentFromURL:routeString];
    NSString *pathKey = [pathComponents componentsJoinedByString:@"."];
    NSRange range = [routeString rangeOfString:@"?"];
    if (range.location != NSNotFound && routeString.length > range.location + range.length) {
        NSString *paramsString = [routeString substringFromIndex:range.location + range.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *p in paramStringArr) {
            @autoreleasepool{
                NSArray *arr = [p componentsSeparatedByString:@"="];
                if (arr.count > 1) {
                    [param setObject:arr[1] forKey:arr[0]];
                }
            }
        }
    }
    Class class = subRoutes[pathKey];
    if (class_isMetaClass(object_getClass(class))) {
        if ([class isSubclassOfClass:[UIViewController class]]) {
            [param setObject:class forKey:@"controller"];
        } else {
            return nil;
        }
    }
    [param setValuesForKeysWithDictionary:userInfo];
    return param;
}

- (NSString *)filterAppSchemeWithRouter:(NSString *)router
{
    NSString *encodeRouter = [router stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLComponents *components = [NSURLComponents componentsWithString:encodeRouter];
    NSString *scheme = components.scheme;
    return scheme.length > 0 ? [router substringFromIndex:scheme.length + 2] : router;
}

- (NSArray *)pathComponentFromURL:(NSString *)URL
{
    NSMutableArray *pathArray = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:[URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    for (NSString *path in url.path.pathComponents) {
        @autoreleasepool{
            if ([path isEqualToString:@"/"]) {
                continue;
            }
            if ([[path substringToIndex:1] isEqualToString:@"?"]) {
                break;
            }
            [pathArray addObject:[path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    return pathArray;
}

- (void)registerRoutersForRouter:(NSString *)router class:(Class)class
{
    NSArray *pathArray = [self pathComponentFromURL:router];
    NSString *routerKey = [pathArray componentsJoinedByString:@"."];
    if (![self.routers objectForKey:routerKey]) {
        [self.routers setObject:class forKey:routerKey];
    }
}

- (NSMutableDictionary *)routers
{
    if (!_routers) {
        _routers = [[NSMutableDictionary alloc] init];
    }
    return _routers;
}

@end

@implementation UIViewController (CMRouter)

- (void)setRouterParamater:(NSDictionary *)routerParamater
{
    objc_setAssociatedObject(self, @selector(setRouterParamater:), routerParamater, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)routerParamater
{
    return objc_getAssociatedObject(self, @selector(setRouterParamater:));
}

- (void)setRouterCallBack:(CMRouterCallBack)routerCallBack
{
    objc_setAssociatedObject(self, @selector(setRouterCallBack:), routerCallBack, OBJC_ASSOCIATION_COPY);
}

- (CMRouterCallBack)routerCallBack
{
    return objc_getAssociatedObject(self, @selector(setRouterCallBack:));
}

@end

