//
//  OCFAppDependency.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFAppDependency.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRoutes.h>
#import <QMUIKit/QMUIKit.h>
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFUser.h"
#import "OCFConfiguration.h"
#import "OCFPreference.h"
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

#pragma mark test
- (void)test:(NSDictionary *)launchOptions {
}

#pragma mark update
- (void)updateConfiguration {
}

- (void)updatePreference {
}

- (void)updateUser {
}

#pragma mark finish
- (void)entryDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    OCFLogDebug(@"运行环境: %@", @(IS_DEBUG));
    OCFLogDebug(@"设备型号: %@", QMUIHelper.deviceName);
    OCFLogDebug(@"系统版本: %@", UIDevice.currentDevice.systemVersion);
    OCFLogDebug(@"屏幕尺寸: %@", NSStringFromCGSize(UIScreen.mainScreen.bounds.size));
    OCFLogDebug(@"安全区域: %@", NSStringFromUIEdgeInsets(SafeAreaInsetsConstantForDeviceWithNotch));
    OCFLogDebug(@"状态栏: %d", (int)StatusBarHeightConstant);
    OCFLogDebug(@"导航栏: %d", (int)NavigationBarHeight);
    OCFLogDebug(@"标签栏: %d", (int)TabBarHeight);
    [OCFAppearanceManager.sharedInstance setup];
    [OCFLibraryManager.sharedInstance setup];
    [OCFRouterManager.sharedInstance setupWithProvider:self.provider navigator:self.navigator];
    [self updateConfiguration];
    [self updatePreference];
    [self updateUser];
}

- (void)leaveDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    [self performSelector:@selector(test:) withObject:launchOptions afterDelay:3.0f];
#endif
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
    OCFLogDebug(@"disk = %@", NSHomeDirectory());
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
    Class cls = NSClassFromString(@"Configuration");
    if ([cls isSubclassOfClass:OCFConfiguration.class]) {
        SEL sel = NSSelectorFromString(@"current");
        OCFConfiguration *configuration = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        [configuration saveWithKey:nil];
    }
    cls = NSClassFromString(@"Preference");
    if ([cls isSubclassOfClass:OCFPreference.class]) {
        SEL sel = NSSelectorFromString(@"current");
        OCFPreference *preference = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        [preference saveWithKey:nil];
    }
    cls = NSClassFromString(@"User");
    if ([cls isSubclassOfClass:OCFUser.class]) {
        SEL sel = NSSelectorFromString(@"current");
        OCFUser *user = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        [user saveWithKey:nil];
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
