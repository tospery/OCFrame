//
//  OCFPlainModel.h
//  OCFrame
//
//  Created by liaoya on 2021/12/16.
//

#import "OCFBaseModel.h"

@interface OCFPlainModel : OCFBaseModel
@property (nonatomic, strong, readonly) id value;

- (instancetype)initWithID:(NSString *)id NS_UNAVAILABLE;
- (instancetype)initWithValue:(id)value;

@end
