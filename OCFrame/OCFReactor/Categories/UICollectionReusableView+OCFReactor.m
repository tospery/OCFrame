//
//  UICollectionReusableView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UICollectionReusableView+OCFReactor.h"
#import <QMUIKit/QMUIKit.h>
#import "OCFDefines.h"
#import "NSString+OCFReactor.h"

@implementation UICollectionReusableView (OCFReactor)

+ (NSString *)ocf_reuseId {
    return OCFStrWithFmt(@"%@Identifier", NSStringFromClass(self));
}

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor {
    return CGSizeMake(flat(maxWidth), OCFMetric(44));
}

@end
