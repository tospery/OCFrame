//
//  OCFCellReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFIdentifiable.h"
#import "OCFBaseModel.h"

@interface OCFCellReactor : OCFBaseReactor <OCFIdentifiable>
@property (nonatomic, strong, readonly) NSString *mid;
@property (nonatomic, strong, readonly) OCFBaseModel *model;
@property (nonatomic, strong, readonly) RACCommand *clickCommand;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMid:(NSString *)mid NS_UNAVAILABLE;
- (instancetype)initWithModel:(OCFBaseModel *)model;

@end

