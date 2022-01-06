//
//  UINavigationController+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/11/29.
//

#import "UINavigationController+OCFrame.h"
#import "UIViewController+OCFrame.h"

@implementation UINavigationController (OCFrame)

+ (UINavigationController *)ocf_currentNavigationController {
    UIViewController *topMost = self.ocf_topMostViewController;
    return topMost.navigationController;
}

@end
