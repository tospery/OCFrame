//
//  UICollectionView+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/11/3.
//

#import "UICollectionView+OCFrame.h"
#import <QMUIKit/QMUIKit.h>

@implementation UICollectionView (OCFrame)

- (CGFloat)widthForSection:(NSInteger)section {
    NSInteger width = self.qmui_width;
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

- (CGFloat)heightForSection:(NSInteger)section {
    NSInteger height = self.qmui_height;
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

- (UICollectionViewCell *)emptyCellForIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"OCFrame.UICollectionView.emptyCell";
    [self registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:identifier];
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.hidden = YES;
    return cell;
}

- (UICollectionReusableView *)emptyViewForIndexPath:(NSIndexPath *)indexPath kind:(NSString *)kind {
    NSString *identifier = @"OCFrame.UICollectionView.emptyView";
    [self registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
    UICollectionReusableView *view = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.hidden = YES;
    return view;
}

@end
