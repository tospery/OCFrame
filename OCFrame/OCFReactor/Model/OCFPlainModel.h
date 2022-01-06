//
//  OCFPlainModel.h
//  OCFrame
//
//  Created by liaoya on 2021/12/16.
//

#import "OCFModel.h"

@interface OCFPlainModel : OCFModel
@property (nonatomic, strong, readonly) id value;

- (instancetype)initWithID:(NSString *)id NS_UNAVAILABLE;
- (instancetype)initWithValue:(id)value;

@end
