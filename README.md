# CMRouter

[![CI Status](http://img.shields.io/travis/momo605654602@gmail.com/CMRouter.svg?style=flat)](https://travis-ci.org/momo605654602@gmail.com/CMRouter)
[![Version](https://img.shields.io/cocoapods/v/CMRouter.svg?style=flat)](http://cocoapods.org/pods/CMRouter)
[![License](https://img.shields.io/cocoapods/l/CMRouter.svg?style=flat)](http://cocoapods.org/pods/CMRouter)
[![Platform](https://img.shields.io/cocoapods/p/CMRouter.svg?style=flat)](http://cocoapods.org/pods/CMRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Conform the protocol<CMRouterProtocol>  and register

```CM_Register_MODULE(user/info);```

Get ViewController from URL.
```
UIViewController *viewController = [[CMRouter sharedInstance] controllerWithURL:@"Cmall://user/info?userId=123&"]
```

## Requirements

## Installation

CMRouter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CMRouter'
```

## Author

Moyun, moyunmo@hotmail.com

## License

CMRouter is available under the MIT license. See the LICENSE file for more info.
