//
//  UICollectionView+OCFrame.h
//  OCFrame
//
//  Created by liaoya on 2021/11/3.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (OCFrame)

- (CGFloat)ocf_widthForSection:(NSInteger)section;
- (CGFloat)ocf_heightForSection:(NSInteger)section;
- (UICollectionViewCell *)ocf_emptyCellForIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)ocf_emptyViewForIndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind;

@end
