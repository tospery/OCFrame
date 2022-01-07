//
//  UICollectionView+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (OCFExtensions)

- (CGFloat)ocf_widthForSection:(NSInteger)section;
- (CGFloat)ocf_heightForSection:(NSInteger)section;
- (UICollectionViewCell *)ocf_emptyCellForIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)ocf_emptyViewForIndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind;

@end

