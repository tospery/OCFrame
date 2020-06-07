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
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFUser.h"
#import "OCFMisc.h"
#import "OCFParameter.h"
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
        [self setupFrame];
        [self setupVendor];
        [self setupAppearance];
        [self setupData];
    }
    return self;
}

#pragma mark - View
#pragma mark - Property

#pragma mark - Method
#pragma mark screen
- (void)initialScreen {
}

#pragma mark setup
- (void)setupFrame {
    // Toast
    [CSToastManager setQueueEnabled:YES];
    [CSToastManager setDefaultPosition:CSToastPositionCenter];
    // Route
    @weakify(self)
    [JLRoutes.globalRoutes addRoute:kOCFPatternToast handler:^BOOL(NSDictionary *parameters) {
        OCFVoidBlock_id completion = OCFObjMember(parameters, OCFParameter.block, nil);
        @strongify(self)
        return [self.navigator.topView ocf_toastWithParameters:parameters completion:^(BOOL didTap) {
            if (completion) {
                completion(@(didTap));
            }
        }];
    }];
}

- (void)setupVendor {
    
}

- (void)setupAppearance {
    
}

- (void)setupData {
    
}

#pragma mark finish
- (void)entryDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
