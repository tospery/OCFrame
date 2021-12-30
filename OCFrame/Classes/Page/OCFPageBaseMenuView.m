//
//  OCFPageBaseMenuView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageBaseMenuView.h"
#import "OCFPageFactory.h"
#import "OCFPageTitleMenuCell.h"
#import "OCFPageIndicatorMenuView.h"

#define kOCFPageHeaderLeftViewTag                (101)
#define kOCFPageHeaderReuseIdentifier            (@"kOCFPageHeaderReuseIdentifier")

struct DelegateFlags {
    unsigned int didSelectedItemAtIndexFlag : 1;
    unsigned int didClickSelectedItemAtIndexFlag : 1;
    unsigned int didScrollSelectedItemAtIndexFlag : 1;
    unsigned int contentScrollViewTransitionToIndexFlag : 1;
    unsigned int scrollingFromLeftIndexToRightIndexFlag : 1;
};

@interface OCFPageBaseMenuView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) struct DelegateFlags delegateFlags;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat innerCellSpacing;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;
@property (nonatomic, assign) BOOL headerClicked;
@property (nonatomic, strong) OCFPageBaseMenuCellModel *leftModel;
@property (nonatomic, strong) OCFPageBaseMenuCell *leftView;

@end

@implementation OCFPageBaseMenuView
- (void)dealloc {
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)setDelegate:(id<OCFPageMenuViewDelegate>)delegate {
    _delegate = delegate;
    
    _delegateFlags.didSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(menuView:didSelectedItemAtIndex:)];
    _delegateFlags.didClickSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(menuView:didClickSelectedItemAtIndex:)];
    _delegateFlags.didScrollSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(menuView:didScrollSelectedItemAtIndex:)];
    _delegateFlags.contentScrollViewTransitionToIndexFlag = [delegate respondsToSelector:@selector(menuView:contentScrollViewTransitionToIndex:)];
    _delegateFlags.scrollingFromLeftIndexToRightIndexFlag = [delegate respondsToSelector:@selector(menuView:scrollingFromLeftIndex:toRightIndex:ratio:)];
}

- (void)initializeData {
    _dataSource = [NSMutableArray array];
    _selectedIndex = kOCFAutomaticDimension;
    _cellWidth = kOCFAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 20;
    _averageCellSpacingEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _contentEdgeInsetLeft = kOCFAutomaticDimension;
    _contentEdgeInsetRight = kOCFAutomaticDimension;
    _lastContentViewContentOffset = CGPointZero;
}

- (void)initializeViews {
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // YJX_TODO
        if (@available(iOS 9.0, *)) {
            layout.sectionHeadersPinToVisibleBounds = YES;
        }
        OCFPageCollectionView *collectionView = [[OCFPageCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
        [collectionView registerClass:[self preferredCellClass] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kOCFPageHeaderReuseIdentifier];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView;
    });
    [self addSubview:self.collectionView];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;
    
    self.selectedIndex = defaultSelectedIndex;
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView {
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;
    
    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)reloadData {
    [self refreshDataSource];
    [self refreshState];
    [self refreshSides];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)reloadCellAtIndex:(NSInteger)index {
    if (index >= self.dataSource.count) {
        return;
    }
    OCFPageBaseMenuCellModel *cellModel = self.dataSource[index];
    [self refreshCellModel:cellModel index:index];
    OCFPageBaseMenuCell *cell = (OCFPageBaseMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self reloadData];
}

#pragma mark - Subclass Override

- (void)refreshDataSource {
    
}

- (void)refreshState {
    if (self.selectedIndex >= self.dataSource.count) {
        self.selectedIndex = 0;
    }
    
    self.innerCellSpacing = self.cellSpacing;
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLeft];
    CGFloat totalCellWidth = 0;
    for (int i = 0; i < self.dataSource.count; i++) {
        OCFPageBaseMenuCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidth = [self preferredCellWidthAtIndex:i] + self.cellWidthIncrement;
        totalCellWidth += cellModel.cellWidth;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellWidthZoomScale = 1.0;
        cellModel.cellSpacing = self.cellSpacing;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else {
            totalItemWidth += cellModel.cellWidth + self.cellSpacing;
        }
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthZoomScale = self.cellWidthZoomScale;
        }else {
            cellModel.selected = NO;
        }
        [self refreshCellModel:cellModel index:i];
    }
    
    if (self.averageCellSpacingEnabled && totalItemWidth < self.bounds.size.width) {
        //如果总的内容宽度都没有超过视图度，就将cellWidth等分
        NSInteger cellSpacingItemCount = self.dataSource.count - 1;
        CGFloat totalCellSpacingWidth = self.bounds.size.width - totalCellWidth;
        //如果内容左边距是Automatic，就加1
        if (self.contentEdgeInsetLeft == kOCFAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetLeft;
        }
        //如果内容右边距是Automatic，就加1
        if (self.contentEdgeInsetRight == kOCFAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetRight;
        }
        
        CGFloat cellSpacing = 0;
        if (cellSpacingItemCount > 0) {
            cellSpacing = totalCellSpacingWidth/cellSpacingItemCount;
        }
        self.innerCellSpacing = cellSpacing;
        [self.dataSource enumerateObjectsUsingBlock:^(OCFPageBaseMenuCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellSpacing = cellSpacing;
        }];
    }
    
    __block CGFloat frameXOfSelectedCell = self.innerCellSpacing;
    __block CGFloat selectedCellWidth = 0;
    totalItemWidth = self.innerCellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(OCFPageBaseMenuCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += cellModel.cellWidth + self.innerCellSpacing;
        }else if (idx == self.selectedIndex) {
            selectedCellWidth = cellModel.cellWidth;
        }
        totalItemWidth += cellModel.cellWidth + self.innerCellSpacing;
    }];
    
    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];
    
    if (CGRectEqualToRect(self.contentScrollView.frame, CGRectZero) && self.contentScrollView.superview != nil) {
        //某些情况、系统会出现JXCategoryView先布局，contentScrollView后布局。就会导致下面指定defaultSelectedIndex失效，所以发现frame为zero时，强行触发布局。
        [self.contentScrollView.superview setNeedsLayout];
        [self.contentScrollView.superview layoutIfNeeded];
    }
    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:NO];
}

- (void)refreshSides {
    if (self.pinToLeft && self.dataSource.count >= 2) {
        self.leftModel = self.dataSource.firstObject;
        self.contentEdgeInsetLeft = -(self.leftModel.cellWidth + self.cellSpacing);
    }else {
        self.leftModel = nil;
    }
    
    if (self.rightView && !self.rightView.superview) {
        CGFloat width = self.rightView.frame.size.width;
        self.rightView.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = self.rightView.bounds;
        [btn addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightView addSubview:btn];
        [self addSubview:self.rightView];
        
        self.contentEdgeInsetRight = width + self.cellSpacing;
    }
}

- (BOOL)selectCellAtIndex:(NSInteger)targetIndex {
    [self scrollOrSelectAtRatio:targetIndex];
    return [self _selectCellAtIndex:targetIndex handleContentScrollView:YES];
}

- (void)scrollOrSelectAtRatio:(CGFloat)ratio {
    if (self.leftModel && self.leftView) {
        self.leftModel.selected = (ratio == 0);
        [self.leftView reloadData:self.leftModel];
        self.leftView.backgroundColor = [UIColor clearColor];
    }
}

- (BOOL)_selectCellAtIndex:(NSInteger)targetIndex handleContentScrollView:(BOOL)handleContentScrollView{
    if (targetIndex >= self.dataSource.count) {
        return NO;
    }
    
    if (self.selectedIndex == targetIndex) {
        if (self.delegateFlags.didSelectedItemAtIndexFlag) {
            [self.delegate menuView:self didSelectedItemAtIndex:targetIndex];
        }
        return NO;
    }
    
    OCFPageBaseMenuCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    OCFPageBaseMenuCellModel *selectedCellModel = self.dataSource[targetIndex];
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];
    
    OCFPageBaseMenuCell *lastCell = (OCFPageBaseMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];
    
    OCFPageBaseMenuCell *selectedCell = (OCFPageBaseMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];
    
    if (self.cellWidthZoomEnabled) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        
        //延时为了解决cellwidth变化，点击最后几个cell，scrollToItem会出现位置偏移bug
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        });
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
    if (handleContentScrollView) {
        if (self.delegateFlags.contentScrollViewTransitionToIndexFlag) {
            [self.delegate menuView:self contentScrollViewTransitionToIndex:targetIndex];
        }else {
            [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];
        }
    }
    
    self.selectedIndex = targetIndex;
    if (self.delegateFlags.didSelectedItemAtIndexFlag) {
        [self.delegate menuView:self didSelectedItemAtIndex:targetIndex];
    }
    
    return YES;
}


- (void)refreshSelectedCellModel:(OCFPageBaseMenuCellModel *)selectedCellModel unselectedCellModel:(OCFPageBaseMenuCellModel *)unselectedCellModel {
    selectedCellModel.selected = YES;
    selectedCellModel.cellWidthZoomScale = self.cellWidthZoomScale;
    unselectedCellModel.selected = NO;
    unselectedCellModel.cellWidthZoomScale = 1.0;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
        //滚动到了最左边，且已经选中了第一个，且之前的contentOffset.x为0
        return;
    }
    CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
    if (contentOffset.x == maxContentOffsetX && self.selectedIndex == self.dataSource.count - 1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
        //滚动到了最右边，且已经选中了最后一个，且之前的contentOffset.x为maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;
    
    [self scrollOrSelectAtRatio:ratio];
    
    if (remainderRatio == 0) {
        //滑动翻页，需要更新选中状态
        //滑动一小段距离，然后放开回到原位，contentOffset同样的值会回调多次。例如在index为1的情况，滑动放开回到原位，contentOffset会多次回调CGPoint(width, 0)
        if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
            [self scrollselectItemAtIndex:baseIndex];
        }
    }else {
        //快速滑动翻页，当remainderRatio没有变成0，但是已经翻页了，需要通过下面的判断，触发选中
        if (fabs(ratio - self.selectedIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectedIndex) {
                targetIndex = baseIndex + 1;
            }
            if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
                [self.delegate menuView:self didScrollSelectedItemAtIndex:targetIndex];
            }
            [self _selectCellAtIndex:targetIndex handleContentScrollView:NO];
        }
        if (self.cellWidthZoomEnabled && self.cellWidthZoomScrollGradientEnabled) {
            OCFPageBaseMenuCellModel *leftCellModel = (OCFPageBaseMenuCellModel *)self.dataSource[baseIndex];
            OCFPageBaseMenuCellModel *rightCellModel = (OCFPageBaseMenuCellModel *)self.dataSource[baseIndex + 1];
            leftCellModel.cellWidthZoomScale = [OCFPageFactory interpolationFrom:self.cellWidthZoomScale to:1.0 percent:remainderRatio];
            rightCellModel.cellWidthZoomScale = [OCFPageFactory interpolationFrom:1.0 to:self.cellWidthZoomScale percent:remainderRatio];
            [self.collectionView.collectionViewLayout invalidateLayout];
        }
        
        if (self.delegateFlags.scrollingFromLeftIndexToRightIndexFlag) {
            [self.delegate menuView:self scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio];
        }
    }
    self.lastContentViewContentOffset = contentOffset;
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return 0;
}

- (Class)preferredCellClass {
    return OCFPageBaseMenuCell.class;
}

- (void)refreshCellModel:(OCFPageBaseMenuCellModel *)cellModel index:(NSInteger)index {
    
}

- (void)rightButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didClickedRightView:)]) {
        [self.delegate menuView:self didClickedRightView:self.rightView];
    }
}

- (void)leftButtonPressed:(id)sender {
    self.headerClicked = YES;
    [self clickselectItemAtIndex:0];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    OCFPageBaseMenuCell *categoryCell = (OCFPageBaseMenuCell *)cell;
    [categoryCell reloadData:self.dataSource[indexPath.item]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.leftModel) {
        return nil;
    }
    
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kOCFPageHeaderReuseIdentifier forIndexPath:indexPath];
        
        if ([reusableView isKindOfClass:[OCFPageBaseMenuCell class]]) {
            OCFPageBaseMenuCell *cell = (OCFPageBaseMenuCell *)reusableView;
            [cell reloadData:self.leftModel];
            cell.backgroundColor = [UIColor clearColor];
            
            if (cell.tag != kOCFPageHeaderLeftViewTag) {
                cell.tag = kOCFPageHeaderLeftViewTag;
                CGFloat start = (self.cellSpacing + self.leftModel.cellWidth) / (self.cellSpacing + self.leftModel.cellWidth + self.cellSpacing);
                CAGradientLayer *layer = [CAGradientLayer layer];
                layer.frame = cell.layer.bounds;
                layer.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor];
                layer.startPoint = CGPointMake(start, 0);
                layer.endPoint = CGPointMake(1, 0);
                layer.zPosition = -1;
                [cell.layer addSublayer:layer];
            }
            
            self.leftView = cell;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = reusableView.bounds;
        [btn addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [reusableView addSubview:btn];
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self clickselectItemAtIndex:indexPath.row];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self getContentEdgeInsetLeft], 0, [self getContentEdgeInsetRight]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    OCFPageBaseMenuCellModel *cellModel = self.dataSource[indexPath.item];
    return CGSizeMake(cellModel.cellWidth, self.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (!self.leftModel) {
        return CGSizeZero;
    }
    CGFloat width = self.leftModel.cellWidth + self.cellSpacing * 2;
    return CGSizeMake(width, collectionView.frame.size.height);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && (self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
        //用户滚动引起的contentOffset变化，才处理。
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
    }
}

#pragma mark - Other

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    CGFloat x = [self getContentEdgeInsetLeft];
    if (self.leftModel) {
        x += (self.leftModel.cellWidth + self.cellSpacing * 2);
    }
    for (int i = 0; i < targetIndex; i ++) {
        OCFPageBaseMenuCellModel *cellModel = self.dataSource[i];
        x += cellModel.cellWidth + self.innerCellSpacing;
    }
    CGFloat width = self.dataSource[targetIndex].cellWidth;
    return CGRectMake(x, 0, width, self.bounds.size.height);
}

#pragma mark - Private

- (CGFloat)getContentEdgeInsetLeft {
    if (self.contentEdgeInsetLeft == kOCFAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetLeft;
}

- (CGFloat)getContentEdgeInsetRight {
    if (self.contentEdgeInsetRight == kOCFAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetRight;
}

- (void)clickselectItemAtIndex:(NSInteger)index {
    if (self.delegateFlags.didClickSelectedItemAtIndexFlag) {
        [self.delegate menuView:self didClickSelectedItemAtIndex:index];
    }
    
    [self selectCellAtIndex:index];
}

- (void)scrollselectItemAtIndex:(NSInteger)index {
    if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
        [self.delegate menuView:self didScrollSelectedItemAtIndex:index];
    }
    
    [self selectCellAtIndex:index];
}

#pragma mark - Page

- (void)resetFrames {
    
}

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index andWidth:(BOOL)update {
    
}

- (void)updateAttributeTitle:(NSAttributedString *)title atIndex:(NSInteger)index andWidth:(BOOL)update {
    
}

//- (OCFPageMenuItem *)itemAtIndex:(NSInteger)index;
/// 立即刷新 menuView 的 contentOffset，使 title 居中
- (void)refreshContenOffset {
    
}

@end

