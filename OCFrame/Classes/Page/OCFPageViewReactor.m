//
//  OCFPageViewReactor.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageViewReactor.h"
#import "OCFParameter.h"
#import "NSDictionary+OCFrame.h"

@interface OCFPageViewReactor ()

@end

@implementation OCFPageViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.selectIndex = OCFIntMember(parameters, OCFParameter.selectIndex, 0);
    }
    return self;
}

#pragma mark - View
#pragma mark - Layout
#pragma mark - Property
#pragma mark - Method
#pragma mark bind
#pragma mark data
#pragma mark error
#pragma mark navigate
#pragma mark request
#pragma mark configure
#pragma mark convenient
#pragma mark - Delegate
#pragma mark - Class

@end
