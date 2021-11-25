//
//  OCFRouterManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFRouterManager.h"
#import "OCFConstant.h"
#import "OCFLoginViewReactor.h"
#import "OCFWebViewReactor.h"
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteHandler.h>
#import <JLRoutes/JLRRouteDefinition.h>

@interface OCFRouterManager ()
@property (nonatomic, strong) OCFProvider *provider;
@property (nonatomic, strong) OCFNavigator *navigator;

@end

@implementation OCFRouterManager

- (void)setupWithProvider:(OCFProvider *)provider navigator:(OCFNavigator *)navigator {
    self.provider = provider;
    self.navigator = navigator;
    JLRoutes.globalRoutes[kOCFPatternLogin] = ^BOOL(NSDictionary *parameters) {
        Class cls = NSClassFromString(@"LoginViewReactor");
        if (![cls isSubclassOfClass:OCFLoginViewReactor.class]) {
            return NO;
        }
        OCFLoginViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
        return [navigator presentReactor:reactor animated:YES completion:nil] != nil;
    };
    JLRoutes.globalRoutes[kOCFPatternAny] = ^BOOL(NSDictionary *parameters) {
        Class cls = NSClassFromString(@"WebViewReactor");
        if (![cls isSubclassOfClass:OCFWebViewReactor.class]) {
            return NO;
        }
        OCFWebViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
        return [navigator pushReactor:reactor animated:YES] != nil;
    };
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
