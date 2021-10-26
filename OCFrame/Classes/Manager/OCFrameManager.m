//
//  OCFrameManager.m
//  OCFrame
//
//  Created by 杨建祥 on 2020/2/28.
//

#import "OCFrameManager.h"
#import <QMUIKit/QMUIKit.h>
#import "NSString+OCFrame.h"
#import "UIApplication+OCFrame.h"

@interface OCFrameManager ()

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

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
