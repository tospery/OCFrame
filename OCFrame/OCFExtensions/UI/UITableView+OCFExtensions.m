//
//  UITableView+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UITableView+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>

@implementation UITableView (OCFExtensions)

- (CGFloat)ocf_widthForSection:(NSInteger)section {
    CGFloat width = self.qmui_width;
    width -= self.contentInset.left;
    width -= self.contentInset.right;
    return width;
}

@end
