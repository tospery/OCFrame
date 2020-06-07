//
//  UICollectionReusableView+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "UICollectionReusableView+OCFrame.h"
#import "NSString+OCFrame.h"

@implementation UICollectionReusableView (OCFrame)
+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

@end
