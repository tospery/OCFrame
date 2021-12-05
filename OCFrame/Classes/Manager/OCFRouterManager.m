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
#import "NSDictionary+OCFrame.h"
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
    JLRoutes.globalRoutes[kOCFHostLogin] = ^BOOL(NSDictionary *parameters) {
        Class cls = NSClassFromString(@"LoginViewReactor");
        if (![cls isSubclassOfClass:OCFLoginViewReactor.class]) {
            return NO;
        }
        OCFLoginViewReactor *reactor = [[cls alloc] initWithParameters:parameters];
        //return [navigator presentReactor:reactor animated:YES completion:nil] != nil;
        return [navigator forwardReactor:reactor];
    };
//    @weakify(self)
//    [JLRoutes.globalRoutes addRoute:kBZMPatternToast handler:^BOOL(NSDictionary *parameters) {
//        BZMVoidBlock_id completion = BZMObjMember(parameters, BZMParameter.block, nil);
//        @strongify(self)
//        return [self.navigator.topView bzm_toastWithParameters:parameters completion:^(BOOL didTap) {
//            if (completion) {
//                completion(@(didTap));
//            }
//        }];
//    }];
//    JLRoutes.globalRoutes[kOCFHostToast] = ^BOOL(NSDictionary *parameters) {
//        return YES;
//    };
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
