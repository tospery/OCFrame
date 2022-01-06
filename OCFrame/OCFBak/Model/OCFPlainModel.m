//
//  OCFPlainModel.m
//  OCFrame
//
//  Created by liaoya on 2021/12/16.
//

#import "OCFPlainModel.h"

@interface OCFPlainModel ()
@property (nonatomic, strong, readwrite) id value;

@end

@implementation OCFPlainModel

- (instancetype)initWithValue:(id)value {
    if (self = [super initWithID:nil]) {
        self.value = value;
    }
    return self;
}

@end
