//
//  OCFCollectionViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollViewReactor.h"
#import "OCFCollectionItem.h"

@class OCFCollectionViewReactor;

@protocol OCFCollectionViewReactorDataSource <OCFScrollViewReactorDataSource, UICollectionViewDataSource>
- (OCFCollectionItem *)collectionViewReactor:(OCFCollectionViewReactor *)collectionViewReactor reactorAtIndexPath:(NSIndexPath *)indexPath;
- (Class)collectionViewReactor:(OCFCollectionViewReactor *)collectionViewReactor classForReactor:(OCFCollectionItem *)reactor;

@end

@interface OCFCollectionViewReactor : OCFScrollViewReactor <OCFCollectionViewReactorDataSource>
@property (nonatomic, strong) NSDictionary *cellMapping;
@property (nonatomic, strong) NSArray *headerNames;
@property (nonatomic, strong) NSArray *footerNames;

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withReactor:(OCFCollectionItem *)reactor;
- (void)configureHeader:(UICollectionReusableView *)header atIndexPath:(NSIndexPath *)indexPath;
- (void)configureFooter:(UICollectionReusableView *)footer atIndexPath:(NSIndexPath *)indexPath;

@end

