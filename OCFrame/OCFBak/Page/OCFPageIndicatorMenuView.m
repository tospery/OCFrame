//
//  OCFPageIndicatorMenuView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorMenuView.h"
#import "OCFPageIndicatorBackgroundView.h"
#import "OCFPageFactory.h"

@interface OCFPageIndicatorMenuView()

@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@end

@implementation OCFPageIndicatorMenuView

- (void)initializeData {
    [super initializeData];
    
    _separatorLineShowEnabled = NO;
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
    _cellBackgroundColorGradientEnabled = NO;
    _cellBackgroundUnselectedColor = [UIColor whiteColor];
    _cellBackgroundSelectedColor = [UIColor lightGrayColor];
}

- (void)initializeViews {
    [super initializeViews];
}

- (void)setIndicators:(NSArray<UIView<OCFPageIndicatorProtocol> *> *)indicators {
    for (UIView *component in self.indicators) {
        //先移除之前的component
        [component removeFromSuperview];
    }
    _indicators = indicators;
    
    for (UIView *component in self.indicators) {
        [self.collectionView addSubview:component];
        component.layer.zPosition = FLT_MAX;
    }
    
    self.collectionView.indicators = indicators;
}

- (void)refreshState {
    [super refreshState];
    
    CGRect selectedCellFrame = CGRectZero;
    OCFPageIndicatorMenuCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        OCFPageIndicatorMenuCellModel *cellModel = (OCFPageIndicatorMenuCellModel *)self.dataSource[i];
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
        cellModel.backgroundViewMaskFrame = CGRectZero;
        cellModel.cellBackgroundColorGradientEnabled = self.cellBackgroundColorGradientEnabled;
        cellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        cellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }

        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            cellModel.selected = YES;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }
    
    for (UIView<OCFPageIndicatorProtocol> *component in self.indicators) {
        if (self.dataSource.count <= 0) {
            component.hidden = YES;
        }else {
            component.hidden = NO;
            [component refreshState:selectedCellFrame];
            
            if ([component isKindOfClass:[OCFPageIndicatorBackgroundView class]]) {
                CGRect maskFrame = component.frame;
                maskFrame.origin.x = maskFrame.origin.x - selectedCellFrame.origin.x;
                selectedCellModel.backgroundViewMaskFrame = maskFrame;
            }
        }
    }
}

- (void)refreshSelectedCellModel:(OCFPageBaseMenuCellModel *)selectedCellModel unselectedCellModel:(OCFPageBaseMenuCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    OCFPageIndicatorMenuCellModel *myUnselectedCellModel = (OCFPageIndicatorMenuCellModel *)unselectedCellModel;
    myUnselectedCellModel.backgroundViewMaskFrame = CGRectZero;
    myUnselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myUnselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
    
    OCFPageIndicatorMenuCellModel *myselectedCellModel = (OCFPageIndicatorMenuCellModel *)selectedCellModel;
    myselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;
    
    // NSLog(@"baseIndex = %ld, ratio = %.2f, remainderRatio = %.2f", baseIndex, ratio, remainderRatio);
    
    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = CGRectZero;
    if (baseIndex + 1 < self.dataSource.count) {
        rightCellFrame = [self getTargetCellFrame:baseIndex+1];
    }
    
    OCFPageCellClickedPosition position = OCFPageCellClickedPositionLeft;
    if (self.selectedIndex == baseIndex + 1) {
        position = OCFPageCellClickedPositionRight;
    }
    
    if (remainderRatio == 0) {
        for (UIView<OCFPageIndicatorProtocol> *component in self.indicators) {
            [component contentScrollViewDidScrollWithLeftCellFrame:leftCellFrame rightCellFrame:rightCellFrame selectedPosition:position percent:remainderRatio];
        }
    }else {
        OCFPageIndicatorMenuCellModel *leftCellModel = (OCFPageIndicatorMenuCellModel *)self.dataSource[baseIndex];
        OCFPageIndicatorMenuCellModel *rightCellModel = (OCFPageIndicatorMenuCellModel *)self.dataSource[baseIndex + 1];
        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];
        
        for (UIView<OCFPageIndicatorProtocol> *component in self.indicators) {
            [component contentScrollViewDidScrollWithLeftCellFrame:leftCellFrame rightCellFrame:rightCellFrame selectedPosition:position percent:remainderRatio];
            if ([component isKindOfClass:[OCFPageIndicatorBackgroundView class]]) {
                CGRect leftMaskFrame = component.frame;
                leftMaskFrame.origin.x = leftMaskFrame.origin.x - leftCellFrame.origin.x;
                leftCellModel.backgroundViewMaskFrame = leftMaskFrame;
                
                CGRect rightMaskFrame = component.frame;
                rightMaskFrame.origin.x = rightMaskFrame.origin.x - rightCellFrame.origin.x;
                rightCellModel.backgroundViewMaskFrame = rightMaskFrame;
            }
        }
        
        OCFPageBaseMenuCell *leftCell = (OCFPageBaseMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadData:leftCellModel];
        OCFPageBaseMenuCell *rightCell = (OCFPageBaseMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadData:rightCellModel];
    }
}

- (BOOL)selectCellAtIndex:(NSInteger)index {
    //是否点击了相对于选中cell左边的cell
    OCFPageCellClickedPosition clickedPosition = OCFPageCellClickedPositionLeft;
    if (index > self.selectedIndex) {
        clickedPosition = OCFPageCellClickedPositionRight;
    }
    BOOL result = [super selectCellAtIndex:index];
    if (!result) {
        return NO;
    }
    
    CGRect clickedCellFrame = [self getTargetCellFrame:index];
    
    OCFPageIndicatorMenuCellModel *selectedCellModel = (OCFPageIndicatorMenuCellModel *)self.dataSource[index];
    for (UIView<OCFPageIndicatorProtocol> *component in self.indicators) {
        [component selectedCell:clickedCellFrame clickedRelativePosition:clickedPosition];
        if ([component isKindOfClass:[OCFPageIndicatorBackgroundView class]]) {
            CGRect maskFrame = component.frame;
            maskFrame.origin.x = maskFrame.origin.x - clickedCellFrame.origin.x;
            selectedCellModel.backgroundViewMaskFrame = maskFrame;
        }
    }
    
    OCFPageIndicatorMenuCell *selectedCell = (OCFPageIndicatorMenuCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadData:selectedCellModel];
    
    return YES;
}


- (void)refreshLeftCellModel:(OCFPageBaseMenuCellModel *)leftCellModel rightCellModel:(OCFPageBaseMenuCellModel *)rightCellModel ratio:(CGFloat)ratio {
    if (self.cellBackgroundColorGradientEnabled) {
        //处理cell背景色渐变
        OCFPageIndicatorMenuCellModel *leftModel = (OCFPageIndicatorMenuCellModel *)leftCellModel;
        OCFPageIndicatorMenuCellModel *rightModel = (OCFPageIndicatorMenuCellModel *)rightCellModel;
        if (leftModel.selected) {
            leftModel.cellBackgroundSelectedColor = [OCFPageFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            leftModel.cellBackgroundUnselectedColor = [OCFPageFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
        if (rightModel.selected) {
            rightModel.cellBackgroundSelectedColor = [OCFPageFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            rightModel.cellBackgroundUnselectedColor = [OCFPageFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
    }
    
}

@end
