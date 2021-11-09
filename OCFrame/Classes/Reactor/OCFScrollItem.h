//
//  OCFScrollItem.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface OCFScrollItem : OCFBaseReactor
@property (nonatomic, strong, readonly) RACCommand *clickCommand;

- (instancetype)initWithParameters:(NSDictionary *)parameters NS_UNAVAILABLE;

@end

