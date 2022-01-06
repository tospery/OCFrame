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
#import "UIColor+OCFrame.h"

@interface OCFWebViewReactor ()
@property (nonatomic, strong, readwrite) NSArray *appHandlers;
@property (nonatomic, strong, readwrite) UIColor *progressColor;
@property (nonatomic, strong, readwrite) OCFEmptyReactor *emptyReactor;

@end

@implementation OCFWebViewReactor
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.appHandlers = OCFArrMember(parameters, OCFParameter.appHandlers, nil);
        NSMutableArray *appHandler = [NSMutableArray arrayWithArray:self.appHandlers];
        [appHandler addObject:@"appHandler"];
        self.appHandlers = appHandler;
        self.progressColor = OCFColorMember(parameters, OCFParameter.progressColor, UIColor.ocf_primary);
    }
    return self;
}

- (void)didInit {
    [super didInit];
    self.emptyReactor = [[OCFEmptyReactor alloc] init];
    RAC(self.emptyReactor, error) = RACObserve(self, error);
}

//- (RACSignal *)loadSignal {
//    return [RACSignal return:self.url];
//}
//
//- (id)data2Source:(id)data {
//    return data;
//}

@end
