//
//  UITableViewHeaderFooterView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UITableViewHeaderFooterView+OCFReactor.h"
#import "NSString+OCFReactor.h"

@implementation UITableViewHeaderFooterView (OCFReactor)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

+ (CGFloat)ocf_heightForSection:(NSInteger)section {
    return 0;
}

@end
