//
//  OCFWebViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFWebViewReactor.h"
#import <JLRoutes/JLRoutes.h>
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFParameter.h"
#import "NSDictionary+OCFrame.h"

@interface OCFWebViewReactor ()
@property (nonatomic, strong, readwrite) NSURL *url;

@end

@implementation OCFWebViewReactor
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.shouldFetchLocalData = OCFBoolMember(parameters, OCFParameter.requestRemote, NO);
        self.shouldRequestRemoteData = OCFBoolMember(parameters, OCFParameter.requestRemote, YES);
        self.ocHandlers = OCFArrMember(parameters, OCFParameter.ocHandlers, nil);
        NSMutableArray *handers = [NSMutableArray arrayWithArray:self.ocHandlers];
        [handers addObject:@"appHandler"];
        self.ocHandlers = handers;
        self.jsHandlers = OCFArrMember(parameters, OCFParameter.jsHandlers, nil);
        self.url = OCFObjWithDft(OCFURLMember(parameters, JLRouteURLKey, nil), OCFURLMember(parameters, OCFParameter.url, nil));
        // YJX_TODO
        // self.progressColor = OCFColorMember(parameters, OCFParameter.progressColor, OCFColorKey(@"primaryColor"));
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
}

@end
