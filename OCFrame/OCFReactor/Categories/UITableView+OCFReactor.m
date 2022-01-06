//
//  UITableView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UITableView+OCFReactor.h"
#import <QMUIKit/QMUIKit.h>

@implementation UITableView (OCFReactor)

- (CGFloat)ocf_widthForSection:(NSInteger)section {
    CGFloat width = self.qmui_width;
    width -= self.contentInset.left;
    width -= self.contentInset.right;
    return width;
}

@end
