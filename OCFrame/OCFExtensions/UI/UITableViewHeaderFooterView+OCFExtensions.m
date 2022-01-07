//
//  UITableViewHeaderFooterView+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UITableViewHeaderFooterView+OCFExtensions.h"
#import "NSString+OCFExtensions.h"

@implementation UITableViewHeaderFooterView (OCFExtensions)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

+ (CGFloat)ocf_heightForSection:(NSInteger)section {
    return 0;
}

@end
