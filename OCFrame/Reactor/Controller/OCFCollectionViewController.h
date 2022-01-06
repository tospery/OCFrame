//
//  OCFCollectionViewController.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollViewController.h"

@interface OCFCollectionViewController : OCFScrollViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

- (UICollectionViewLayout *)collectionViewLayout;

@end

