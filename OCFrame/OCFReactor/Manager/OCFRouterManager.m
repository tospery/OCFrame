//
//  OCFRouterManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFRouterManager.h"
#import <OCFrame/OCFExtensions.h>
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteHandler.h>
#import <JLRoutes/JLRRouteDefinition.h>
#import "OCFLoginViewReactor.h"
#import "OCFWebViewReactor.h"
#import "OCFParameter.h"

@interface OCFRouterManager ()
@property (nonatomic, strong) OCFProvider *provider;
@property (nonatomic, strong) OCFNavigator *navigator;

@end

@implementation OCFRouterManager

- (void)setupWithProvider:(OCFProvider *)provider navigator:(OCFNavigator *)navigator {
    self.provider = provider;
    self.navigator = navigator;
    JLRoutes.globalRoutes[kOCFHostLogin] = ^BOOL(NSDictionary *parameters) {
        Class cls = NSClassFromString(@"LoginViewReactor");
        if (![cls isSubclassOfClass:OCFLoginViewReactor.class]) {
            return NO;
        }
        OCFLoginViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
        return [navigator forwardReactor:reactor];
    };
    JLRoutes.globalRoutes[kOCFHostThirdparty] = ^BOOL(NSDictionary *parameters) {
        NSURL *url = [OCFStrMember(parameters, OCFParameter.url, nil) ocf_urlComponentDecoded].ocf_url;
        if (url) {
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
            return YES;
        }
        NSString *string = [OCFStrMember(parameters, OCFParameter.urls, nil) ocf_base64Decoded];
        id json = [string ocf_JSONObject];
        if ([json isKindOfClass:NSArray.class]) {
            NSArray *arr = (NSArray *)json;
            for (NSString *item in arr) {
                if ([UIApplication.sharedApplication canOpenURL:item.ocf_url]) {
                    [UIApplication.sharedApplication openURL:item.ocf_url options:@{} completionHandler:nil];
                    return YES;
                }
            }
        }
        return NO;
    };
    JLRoutes.globalRoutes[kOCFHostAny] = ^BOOL(NSDictionary *parameters) {
        NSString *scheme = OCFURLMember(parameters, JLRouteURLKey, nil).scheme;
        if (![scheme isEqualToString:@"http"] && ![scheme isEqualToString:@"https"]) {
            return NO;
        }
        Class cls = NSClassFromString(@"WebViewReactor");
        if (![cls isSubclassOfClass:OCFWebViewReactor.class]) {
            return NO;
        }
        OCFWebViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
        return [navigator forwardReactor:reactor];
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
