//
//  OCFAppDependency.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFAppDependency.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRoutes.h>
#import <Toast/UIView+Toast.h>
#import <QMUIKit/QMUIKit.h>
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFUser.h"
#import "OCFMisc.h"
#import "OCFParameter.h"
#import "OCFAppearanceManager.h"
#import "OCFLibraryManager.h"
#import "OCFRouterManager.h"
#import "NSDictionary+OCFrame.h"
#import "UIView+OCFrame.h"

@interface OCFAppDependency ()
@property (nonatomic, strong, readwrite) OCFProvider *provider;
@property (nonatomic, strong, readwrite) OCFNavigator *navigator;

@end

@implementation OCFAppDependency

#pragma mark - Init
- (instancetype)init {
    if (self = [super init]) {
        self.provider = [[OCFProvider alloc] init];
        self.navigator = [[OCFNavigator alloc] init];
    }
    return self;
}

#pragma mark - View
#pragma mark - Property

#pragma mark - Method
#pragma mark screen
- (void)initialScreen {
}

#pragma mark finish
- (void)entryDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    OCFLogDebug(kOCFLogTagNormal, @"运行环境: %@", @(IS_DEBUG));
    OCFLogDebug(kOCFLogTagNormal, @"设备型号: %@", QMUIHelper.deviceName);
    OCFLogDebug(kOCFLogTagNormal, @"系统版本: %@", UIDevice.currentDevice.systemVersion);
    OCFLogDebug(kOCFLogTagNormal, @"屏幕尺寸: %@", NSStringFromCGSize(UIScreen.mainScreen.bounds.size));
    OCFLogDebug(kOCFLogTagNormal, @"刘海尺寸: %@", NSStringFromUIEdgeInsets(SafeAreaInsetsConstantForDeviceWithNotch));
    OCFLogDebug(kOCFLogTagNormal, @"状态栏%d, 导航栏%d, 标签栏%d", (int)StatusBarHeightConstant, NavigationBarHeight, (int)TabBarHeight);
    [OCFAppearanceManager.sharedInstance setup];
    [OCFLibraryManager.sharedInstance setup];
    [OCFRouterManager.sharedInstance setupWithProvider:self.provider navigator:self.navigator];
}

- (void)leaveDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
}

#pragma mark status
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    OCFLogDebug(kOCFLogTagNormal, @"disk = %@", NSHomeDirectory());
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self save];
}

#pragma mark url
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [JLRoutes routeURL:url];
}

#pragma mark save
- (void)save {
    Class cls = NSClassFromString(@"User");
    if ([cls isSubclassOfClass:OCFUser.class]) {
        SEL sel = NSSelectorFromString(@"current");
        OCFUser *user = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        [user saveWithKey:nil];
    }
    cls = NSClassFromString(@"Misc");
    if ([cls isSubclassOfClass:OCFMisc.class]) {
        SEL sel = NSSelectorFromString(@"current");
        OCFMisc *misc = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        [misc saveWithKey:nil];
    }
}

#pragma mark - Delegate
#pragma mark - Class
+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
