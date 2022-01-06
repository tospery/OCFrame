//
//  OCFModel.h
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import "OCFStorable.h"
#import <libextobjc/extobjc.h>

@protocol OCFModel <OCFStorable>
@concrete
@property (nonatomic, assign, readonly) BOOL isValid;
+ (instancetype)current;

@end
