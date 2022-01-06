//
//  OCFScrollItem.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFModel.h"

@interface OCFScrollItem : OCFBaseReactor
@property (nonatomic, strong, readonly) OCFModel *model;
@property (nonatomic, strong, readonly) RACCommand *clickCommand;
@property (nonatomic, strong) NSString *target;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithModel:(OCFModel *)model;

@end

