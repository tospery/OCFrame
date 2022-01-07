//
//  UICollectionReusableView+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import "OCFCollectionItem.h"

@interface UICollectionReusableView (OCFReactor)

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor;

@end
