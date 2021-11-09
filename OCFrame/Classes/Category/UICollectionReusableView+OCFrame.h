//
//  UICollectionReusableView+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import <UIKit/UIKit.h>
#import "OCFCollectionItem.h"

@interface UICollectionReusableView (OCFrame)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor;

@end

