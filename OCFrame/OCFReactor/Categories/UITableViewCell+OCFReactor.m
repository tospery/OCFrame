//
//  UITableViewCell+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "UITableViewCell+OCFReactor.h"
#import <OCFrame/OCFExtensions.h>

@implementation UITableViewCell (OCFReactor)

+ (CGFloat)ocf_heightWithItem:(OCFTableItem *)item {
    return OCFMetric(44);
}

@end
