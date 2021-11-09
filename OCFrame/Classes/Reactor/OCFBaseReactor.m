//
//  OCFBaseReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFBaseReactor.h"

@interface OCFBaseReactor ()
@property (nonatomic, strong, readwrite) OCFBaseModel *model;
@property (nonatomic, strong, readwrite) NSDictionary *parameters;

@end

@implementation OCFBaseReactor

- (instancetype)initWithModel:(OCFBaseModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super init]) {
        self.parameters = parameters;
    }
    return self;
}

- (void)didInitialize {
    
}

@end
