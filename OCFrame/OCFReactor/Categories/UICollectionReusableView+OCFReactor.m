//
//  UICollectionReusableView+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "UICollectionReusableView+OCFReactor.h"
#import <OCFrame/OCFExtensions.h>

@implementation UICollectionReusableView (OCFReactor)

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor {
    return CGSizeMake(flat(maxWidth), OCFMetric(44));
}

@end
