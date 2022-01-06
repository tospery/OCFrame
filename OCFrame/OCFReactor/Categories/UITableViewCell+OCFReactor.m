//
//  UITableViewCell+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UITableViewCell+OCFReactor.h"
#import "NSString+OCFReactor.h"

@implementation UITableViewCell (OCFReactor)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

@end
