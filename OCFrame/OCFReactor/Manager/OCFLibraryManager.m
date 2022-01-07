//
//  OCFLibraryManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFLibraryManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRoutes.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import <OCFrame/OCFCore.h>
#import "OCFReachManager.h"
#import "OCFrameManager.h"

@interface OCFLibraryManager ()

@end

@implementation OCFLibraryManager

- (void)setup {
    [self setupAFNetworking];
    [self setupAFNetworkActivityLogger];
}

- (void)setupAFNetworking {
//    [AFNetworkReachabilityManager.sharedManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        OCFLogDebug(@"网络状态: %@", @(status));
//        [REACH_SUBJECT sendNext:@(status)];
//    }];
//    [AFNetworkReachabilityManager.sharedManager startMonitoring];
}

- (void)setupAFNetworkActivityLogger {
//#ifdef DEBUG
//    [AFNetworkActivityLogger.sharedLogger setLogLevel:AFLoggerLevelDebug];
//    [AFNetworkActivityLogger.sharedLogger startLogging];
//#endif
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
