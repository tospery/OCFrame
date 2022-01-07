//
//  UICollectionReusableView+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UICollectionReusableView+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>
#import <OCFrame/OCFCore.h>
#import "NSString+OCFExtensions.h"

@implementation UICollectionReusableView (OCFExtensions)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

@end
