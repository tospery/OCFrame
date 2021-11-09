//
//  OCFBaseReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <Foundation/Foundation.h>
#import "OCFBaseModel.h"

@interface OCFBaseReactor : NSObject
@property (nonatomic, strong, readonly) OCFBaseModel *model;
@property (nonatomic, strong, readonly) NSDictionary *parameters;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(OCFBaseModel *)model;
- (instancetype)initWithParameters:(NSDictionary *)parameters;

- (void)didInitialize;

@end

