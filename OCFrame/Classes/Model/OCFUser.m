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
#import "OCFLoginViewController.h"
#import "UIViewController+OCFrame.h"

@interface OCFUser ()

@end

@implementation OCFUser

- (void)logout {
    [self mergeValuesForKeysFromModel:[[self.class alloc] init]];
}

+ (BOOL)canAutoOpenLoginPage {
    UIViewController *topMost = UIViewController.ocf_topMostViewController;
    if ([topMost isKindOfClass:OCFLoginViewController.class]) {
        return NO;
    }
    return YES;
}

@end
