//
//  UITableView+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "UITableView+OCFrame.h"
#import <QMUIKit/QMUIKit.h>

@implementation UITableView (OCFrame)

- (CGFloat)ocf_widthForSection:(NSInteger)section {
    CGFloat width = self.qmui_width;
    width -= self.contentInset.left;
    width -= self.contentInset.right;
    return width;
}

@end
