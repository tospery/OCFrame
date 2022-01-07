//
//  UINavigationController+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UINavigationController+OCFExtensions.h"
#import "UIViewController+OCFExtensions.h"

@implementation UINavigationController (OCFExtensions)

+ (UINavigationController *)ocf_current {
    UIViewController *topMost = self.ocf_topMost;
    return topMost.navigationController;
}

@end
