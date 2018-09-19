# Piano SDK for iOS
Piano SDK includes embedded dynamic frameworks written in Swift.

- **[PianoComposer](http://cocoapods.org/pods/PianoComposer):** provides access to the mobile composer

[![Version](https://img.shields.io/cocoapods/v/PianoComposer.svg?style=flat)](http://cocoapods.org/pods/PianoComposer)
[![Platform](https://img.shields.io/cocoapods/p/PianoComposer.svg?style=flat)](http://cocoapods.org/pods/PianoComposer)
[![License](https://img.shields.io/cocoapods/l/PianoComposer.svg?style=flat)](http://cocoapods.org/pods/PianoComposer)

- **[PianoOAuth](http://cocoapods.org/pods/PianoOAuth):** component for authentication tinypass accounts). Frameworks can be used for development iOS applications on Objective C and Swift.

[![Version](https://img.shields.io/cocoapods/v/PianoOAuth.svg?style=flat)](http://cocoapods.org/pods/PianoOAuth)
[![Platform](https://img.shields.io/cocoapods/p/PianoOAuth.svg?style=flat)](http://cocoapods.org/pods/PianoOAuth)
[![License](https://img.shields.io/cocoapods/l/PianoOAuth.svg?style=flat)](http://cocoapods.org/pods/PianoOAuth)

This document details the process of integrating the Piano SDK with your iOS application. If you have any questions, don't hesitate to email us at support@piano.io.

## Requirements
- iOS 8.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

### [CocoaPods](https://cocoapods.org/)

Add the following lines to your `Podfile`.

```
use_frameworks!

pod 'PianoComposer', '~>2.1.0'
pod 'PianoOAuth', '~>2.1.0'
```

Then run `pod install`. For details of the installation and usage of CocoaPods, visit [official web site](https://cocoapods.org/).


## Standard Usage

### Swift
##### Imports
```Swift
import PianoComposer
import PianoOAuth
```

##### Composer initialization
```Swift
var composer = PianoComposer(aid: "AID")
.delegate(delegate: self) // conform PianoComposerDelegate protocol
.tag(tag: "tag1") // add single tag
.tag(tag: "tag2") // add single tag
.tags(tagCollection: ["tag3", "tag4"]) //add array of tags
.zoneId(zoneId: "Zone1") // set zone
.referrer(referrer: "http://sitename.com") // set referrer
.url(url: "http://pubsite.com/page1") // set url
.customVariable(name: "customId", value: "1") // set custom variable
.userToken(userToken: "userToken") // set user token
```

##### Switch to sandbox
```Swift
let composer = PianoComposer(aid: "AID", sandbox: true)
// or
let composer = PianoComposer(aid: "AID", endpointUrl: PianoComposer.sandboxEndpointUrl)
// or
let composer = PianoComposer(aid: "AID")
composer.endpointUrl(endpointUrl: PianoComposer.sandboxEndpointUrl)
```

##### Composer execution
```Swift 
composer.execute()
``` 

##### PianoComposerDelegate protocol
```Swift
// Client actions
optional func composerExecutionCompleted(composer: PianoComposer)

// Composer actions from server 
optional func showLogin(composer: PianoComposer, event: XpEvent, params: ShowLoginEventParams?)
optional func showTemplate(composer: PianoComposer, event: XpEvent, params: ShowTemplateEventParams?)
optional func nonSite(composer: PianoComposer, event: XpEvent)
optional func userSegmentTrue(composer: PianoComposer, event: XpEvent)
optional func userSegmentFalse(composer: PianoComposer, event: XpEvent)    
optional func meterActive(composer: PianoComposer, event: XpEvent, params: PageViewMeterEventParams?)
optional func meterExpired(composer: PianoComposer, event: XpEvent, params: PageViewMeterEventParams?)    
optional func experienceExecute(composer: PianoComposer, event: XpEvent, params: ExperienceExecuteEventParams?)
```

##### OAuth usage
```Swift
let vc = PianoOAuthPopupViewController(aid: "AID") // for tinypass accounts user provider
// or
let vc = PianoIdOAuthPopupViewController(aid: "AID") // for piano id user provider
...
vc.delegate = someDelegate // conform PianoOAuthDelegate protocol
vc.signUpEnabled = true // makes "sign up" button enabled (default: false)
vc.widgetType = .login // widget type (possible values: ".login", ".register")
vc.showPopup()
```

##### PianoOAuthDelegate protocol
```Swift
func loginSucceeded(accessToken: String)
func loginCancelled() 
```

### Objective C
##### Imports
```objective-c
#import "PianoOAuth/PianoOAuth-Swift.h"
#import "PianoComposer/PianoComposer-Swift.h"
```

##### Composer initialization
```objective-c
PianoComposer *composer = [[PianoComposer alloc] initWithAid:@"AID"];
composer.delegate = self;
composer.tags = [NSSet setWithObjects: @"tag1", @"tag2", nil]; // set tags
composer.referrer = @"http://sitename.com"; // set referrer
composer.url = @"http://pubsite.com/page1"; // set url
composer.zoneId = @"Zone1";
composer.userToken = @"userToken";
composer.customVariables = [[NSDictionary alloc] initWithObjectsAndKeys: @"1", @"customId", nil];
```

##### Composer execution
```objective-c 
[composer execute]
``` 

##### PianoComposerDelegate protocol
```objective-c

@optional
- (void)composerExecutionCompleted:(PianoComposer * _Nonnull)composer;
- (void)showLogin:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event params:(ShowLoginEventParams * _Nullable)params;
- (void)showTemplate:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event params:(ShowTemplateEventParams * _Nullable)params;
- (void)nonSite:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event;
- (void)userSegmentTrue:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event;
- (void)userSegmentFalse:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event;
- (void)meterActive:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event params:(PageViewMeterEventParams * _Nullable)params;
- (void)meterExpired:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event params:(PageViewMeterEventParams * _Nullable)params;
- (void)experienceExecute:(PianoComposer * _Nonnull)composer event:(XpEvent * _Nonnull)event params:(ExperienceExecuteEventParams * _Nullable)params;
```

##### OAuth usage
```objective-c 
PianoOAuthPopupViewController *vc = [[PianoOAuthPopupViewController alloc] initWithAid:@"AID"];
vc.delegate = self;
vc.signUpEnabled = true;
vc.widgetType = WidgetTypeLogin;
[vc showPopup];
```

##### PianoOAuthDelegate protocol
```objective-c 
- (void)loginSucceeded:(NSString * _Nonnull)accessToken;
- (void)loginCancelled;
```


### Screenshots
<img src="Images/oauth_iphone.png" alt="OAuth_screenshot_1" height="335px" width="200px" />
<img src="Images/oauth_ipad.png" alt="OAuth_screenshot_2" height="335px" width="446px" />
