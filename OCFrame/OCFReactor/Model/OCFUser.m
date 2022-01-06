//
//  OCFUser.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFUser.h"
#import <Mantle_JX/Mantle.h>
#import "OCFDefines.h"
#import "OCFDefines.h"
#import "OCFLoginViewController.h"
#import "UIViewController+OCFReactor.h"

@interface OCFUser ()

@end

@implementation OCFUser

- (void)logout {
    [self mergeValuesForKeysFromModel:[[self.class alloc] init]];
}

+ (BOOL)canAutoOpenLoginPage {
    UIViewController *topMost = UIViewController.ocf_topMost;
    if ([topMost isKindOfClass:OCFLoginViewController.class]) {
        return NO;
    }
    return YES;
}

@end
