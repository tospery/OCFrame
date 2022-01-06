//
//  OCFPageIndicatorBackgroundView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorBackgroundView.h"
#import "OCFPageFactory.h"

@interface OCFPageIndicatorBackgroundView ()

@end

@implementation OCFPageIndicatorBackgroundView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _backgroundViewWidth = kOCFAutomaticDimension;
        _backgroundViewHeight = kOCFAutomaticDimension;
        _backgroundViewCornerRadius = kOCFAutomaticDimension;
        _backgroundViewColor = [UIColor lightGrayColor];
        _backgroundViewWidthIncrement = 10;
    }
    return self;
}

#pragma mark - OCFPageIndicatorProtocol
- (void)refreshState:(CGRect)selectedCellFrame {
    self.layer.cornerRadius = [self getBackgroundViewCornerRadius:selectedCellFrame];
    self.backgroundColor = self.backgroundViewColor;
    
    CGFloat width = [self getBackgroundViewWidth:selectedCellFrame];
    CGFloat height = [self getBackgroundViewHeight:selectedCellFrame];
    CGFloat x = selectedCellFrame.origin.x + (selectedCellFrame.size.width - width)/2;
    CGFloat y = (selectedCellFrame.size.height - height)/2;
    self.frame = CGRectMake(x, y, width, height);
}

- (void)contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(OCFPageCellClickedPosition)selectedPosition percent:(CGFloat)percent {
    
    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getBackgroundViewWidth:leftCellFrame];
    
    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getBackgroundViewWidth:rightCellFrame];
        
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        
        targetX = [OCFPageFactory interpolationFrom:leftX to:rightX percent:percent];
        
        if (self.backgroundViewWidth == kOCFAutomaticDimension) {
            targetWidth = [OCFPageFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
        }
    }
    
    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGFloat height = [self getBackgroundViewHeight:leftCellFrame];
        CGFloat y = (leftCellFrame.size.height - height)/2;
        self.frame = CGRectMake(targetX, y, targetWidth, height);
    }
}

- (void)selectedCell:(CGRect)cellFrame clickedRelativePosition:(OCFPageCellClickedPosition)clickedRelativePosition {
    CGFloat width = [self getBackgroundViewWidth:cellFrame];
    CGFloat height = [self getBackgroundViewHeight:cellFrame];
    CGFloat x = cellFrame.origin.x + (cellFrame.size.width - width)/2;
    CGFloat y = (cellFrame.size.height - height)/2;
    CGRect toFrame = CGRectMake(x, y, width, height);
    
    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.frame = toFrame;
    }
}

#pragma mark - Private
- (CGFloat)getBackgroundViewWidth:(CGRect)cellFrame {
    if (self.backgroundViewWidth == kOCFAutomaticDimension) {
        return cellFrame.size.width  + self.backgroundViewWidthIncrement;
    }
    return self.backgroundViewWidth + self.backgroundViewWidthIncrement;
}

- (CGFloat)getBackgroundViewHeight:(CGRect)cellFrame {
    if (self.backgroundViewHeight == kOCFAutomaticDimension) {
        return cellFrame.size.height;
    }
    return self.backgroundViewHeight;
}

- (CGFloat)getBackgroundViewCornerRadius:(CGRect)cellFrame {
    if (self.backgroundViewCornerRadius == kOCFAutomaticDimension) {
        return [self getBackgroundViewHeight:cellFrame]/2;
    }
    return self.backgroundViewCornerRadius;
}

@end
