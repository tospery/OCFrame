//
//  UICollectionView+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UICollectionView+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>

@implementation UICollectionView (OCFExtensions)

- (CGFloat)ocf_widthForSection:(NSInteger)section {
    CGFloat width = self.qmui_width;
    width -= self.contentInset.left;
    width -= self.contentInset.right;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.delegate;
        UIEdgeInsets sectionInset = [delegate collectionView:self layout:self.collectionViewLayout insetForSectionAtIndex:section];
        width -= sectionInset.left;
        width -= sectionInset.right;
    } else if ([self.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionViewLayout sectionInset];
        width -= sectionInset.left;
        width -= sectionInset.right;
    }
    return width;
}

- (CGFloat)ocf_heightForSection:(NSInteger)section {
    CGFloat height = self.qmui_height;
    height -= self.contentInset.top;
    height -= self.contentInset.bottom;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.delegate;
        UIEdgeInsets sectionInset = [delegate collectionView:self layout:self.collectionViewLayout insetForSectionAtIndex:section];
        height -= sectionInset.top;
        height -= sectionInset.bottom;
    } else if ([self.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]) {
        UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionViewLayout sectionInset];
        height -= sectionInset.top;
        height -= sectionInset.bottom;
    }
    return height;
}

- (UICollectionViewCell *)ocf_emptyCellForIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"OCFrame.UICollectionView.emptyCell";
    [self registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:identifier];
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.hidden = YES;
    return cell;
}

- (UICollectionReusableView *)ocf_emptyViewForIndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind {
    NSString *identifier = @"OCFrame.UICollectionView.emptyView";
    [self registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
    UICollectionReusableView *view = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.hidden = YES;
    return view;
}

@end
