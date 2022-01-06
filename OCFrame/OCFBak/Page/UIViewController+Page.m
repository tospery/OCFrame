//
//  UIViewController+Page.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "UIViewController+Page.h"

@implementation UIViewController (Page)

- (OCFPageViewController *)ocf_pageViewController {
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController) {
        if ([parentViewController isKindOfClass:[OCFPageViewController class]]) {
            return (OCFPageViewController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

@end
