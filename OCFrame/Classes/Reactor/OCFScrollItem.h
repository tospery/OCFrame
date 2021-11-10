//
//  OCFScrollItem.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFBaseModel.h"

@interface OCFScrollItem : OCFBaseReactor
@property (nonatomic, strong, readonly) OCFBaseModel *model;
@property (nonatomic, strong, readonly) RACCommand *clickCommand;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(OCFBaseModel *)model;

@end

