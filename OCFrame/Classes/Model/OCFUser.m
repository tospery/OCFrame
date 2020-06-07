//
//  OCFUser.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFUser.h"
#import <Mantle/Mantle.h>
#import "OCFConstant.h"
#import "OCFFunction.h"

@interface OCFUser ()

@end

@implementation OCFUser

- (void)logout {
    [self mergeValuesForKeysFromModel:[[self.class alloc] init]];
}

@end
