//
//  CMRouter.h
//  CMRouter
//
//  Created by Moyun on 2017/8/20.
//  Copyright © 2017年 Cmall. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined(__cplusplus)
#define CM_EXTERN extern "C" __attribute__((visibility("default")))
#else
#define CM_EXTERN extern __attribute__((visibility("default")))
#endif

typedef void(^CMRouterCallBack) (NSString *tag, id result);

@protocol CMRouterProtocol <NSObject>

#define CM_Register_MODULE(moudle_name) \
CM_EXTERN void CMRegisterModule(Class); \
+ (NSString *)moduleName { return @#moudle_name; } \
+ (void)load { CMRegisterModule(self); }

+ (NSString *)moduleName;

@end

CM_EXTERN NSString *CMModuleNameForClass(Class moduleClass);

@interface CMRouter : NSObject

+ (CMRouter *)sharedInstance;

- (void)setUpMoudles;

- (UIViewController *)controllerWithURL:(NSString *)URL;

- (UIViewController *)controllerWithURL:(NSString *)URL
                               userInfo:(NSDictionary *)userInfo;

- (UIViewController *)controllerWithURL:(NSString *)URL
                               userInfo:(NSDictionary *)userInfo
                               complete:(CMRouterCallBack)complete;

+ (BOOL)canRouter:(NSString *)router;

@end

@interface UIViewController (CMRouter)

@property (strong, nonatomic) NSDictionary *routerParamater;

@property (copy ,  nonatomic) CMRouterCallBack routerCallBack;

@end
