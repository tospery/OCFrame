//
//  UITableViewCell+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "UITableViewCell+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import "OCFFunction.h"
#import "NSString+OCFrame.h"

@implementation UITableViewCell (OCFrame)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

+ (CGFloat)ocf_heightWithItem:(OCFTableItem *)item {
    return OCFMetric(44);
}

@end
