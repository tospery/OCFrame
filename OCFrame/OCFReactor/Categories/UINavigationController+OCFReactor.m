//
//  UINavigationController+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UINavigationController+OCFReactor.h"
#import "UIViewController+OCFReactor.h"

@implementation UINavigationController (OCFReactor)

+ (UINavigationController *)ocf_current {
    UIViewController *topMost = self.ocf_topMost;
    return topMost.navigationController;
}

@end
