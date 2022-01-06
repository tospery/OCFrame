//
//  UICollectionReusableView+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "OCFCollectionItem.h"

@interface UICollectionReusableView (OCFReactor)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor;

@end

