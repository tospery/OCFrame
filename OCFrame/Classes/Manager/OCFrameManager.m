//
//  OCFrameManager.m
//  OCFrame
//
//  Created by 杨建祥 on 2020/2/28.
//

#import "OCFrameManager.h"
#import <QMUIKit/QMUIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "NSString+OCFrame.h"
#import "UIApplication+OCFrame.h"

@interface OCFrameManager ()
@property (nonatomic, strong, readwrite) RACBehaviorSubject *reachSubject;

@end

@implementation OCFrameManager
- (instancetype)init {
    if (self = [super init]) {
        self.autoLogin = YES;
        self.loginPattern = @"login";
        self.appScheme = UIApplication.sharedApplication.ocf_urlScheme;
        self.baseURLString = OCFStrWithFmt(@"https://m.%@.com", self.appScheme);
        self.fontScale = IS_320WIDTH_SCREEN ? -2 : 0;
        self.page = [[OCFPage alloc] init];
    }
    return self;
}

- (RACBehaviorSubject *)reachSubject {
    if (!_reachSubject) {
        RACBehaviorSubject *subject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(AFNetworkReachabilityStatusUnknown)];
        _reachSubject = subject;
    }
    return _reachSubject;
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
