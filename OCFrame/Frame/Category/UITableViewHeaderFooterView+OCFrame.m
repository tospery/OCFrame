//
//  UITableViewHeaderFooterView+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "UITableViewHeaderFooterView+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import "OCFFunction.h"
#import "NSString+OCFrame.h"

@implementation UITableViewHeaderFooterView (OCFrame)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

+ (CGFloat)ocf_heightForSection:(NSInteger)section {
    return 0;
}

@end
