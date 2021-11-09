//
//  OCFAppDependency.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFProvider.h"
#import "OCFNavigator.h"

@interface OCFAppDependency : NSObject
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong, readonly) OCFProvider *provider;
@property (nonatomic, strong, readonly) OCFNavigator *navigator;

- (void)initialScreen;

//- (void)setupFrame;
//- (void)setupVendor;
//- (void)setupAppearance;
//- (void)setupData;

- (void)entryDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)leaveDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidEnterBackground:(UIApplication *)application;
- (void)applicationWillEnterForeground:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

+ (instancetype)sharedInstance;

@end

