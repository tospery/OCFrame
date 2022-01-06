//
//  OCFPageIndicatorLineView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorLineView.h"
#import "OCFPageFactory.h"

@interface OCFPageIndicatorLineView ()

@end

@implementation OCFPageIndicatorLineView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _lineStyle = OCFPageIndicatorLineStyleNormal;
        _lineScrollOffsetX = 10;
        _indicatorLineViewHeight = 3;
        _indicatorLineWidth = kOCFAutomaticDimension;
        _indicatorLineViewColor = [UIColor redColor];
        _indicatorLineViewCornerRadius = kOCFAutomaticDimension;
    }
    return self;
}

#pragma mark - OCFPageIndicatorProtocol
- (void)refreshState:(CGRect)selectedCellFrame {
    self.backgroundColor = self.indicatorLineViewColor;
    self.layer.cornerRadius = [self getIndicatorLineViewCornerRadius];
    
    CGFloat selectedLineWidth = [self getIndicatorLineViewWidth:selectedCellFrame];
    CGFloat x = selectedCellFrame.origin.x + (selectedCellFrame.size.width - selectedLineWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorLineViewHeight - self.verticalMargin;
    if (self.componentPosition == OCFPageComponentPositionTop) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, selectedLineWidth, self.indicatorLineViewHeight);
}

- (void)contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(OCFPageCellClickedPosition)selectedPosition percent:(CGFloat)percent {
    
    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getIndicatorLineViewWidth:leftCellFrame];
    
    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getIndicatorLineViewWidth:rightCellFrame];
        
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        
        if (self.lineStyle == OCFPageIndicatorLineStyleNormal) {
            targetX = [OCFPageFactory interpolationFrom:leftX to:rightX percent:percent];
            
            if (self.indicatorLineWidth == kOCFAutomaticDimension) {
                targetWidth = [OCFPageFactory interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:percent];
            }
        }else if (self.lineStyle == OCFPageIndicatorLineStyleJD) {
            CGFloat maxWidth = rightX - leftX + rightWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (percent <= 0.5) {
                targetX = leftX;
                targetWidth = [OCFPageFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [OCFPageFactory interpolationFrom:leftX to:rightX percent:(percent - 0.5)*2];
                targetWidth = [OCFPageFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }else if (self.lineStyle == OCFPageIndicatorLineStyleIQIYI) {
            //前50%，增加width，并少量移动x；后50%，少量移动x并减小width
            CGFloat offsetX = self.lineScrollOffsetX;//x的少量偏移量
            CGFloat maxWidth = rightX - leftX + rightWidth - offsetX*2;
            if (percent <= 0.5) {
                targetX = [OCFPageFactory interpolationFrom:leftX to:leftX + offsetX percent:percent*2];;
                targetWidth = [OCFPageFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [OCFPageFactory interpolationFrom:(leftX + offsetX) to:rightX percent:(percent - 0.5)*2];
                targetWidth = [OCFPageFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }
    }
    
    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)selectedCell:(CGRect)cellFrame clickedRelativePosition:(OCFPageCellClickedPosition)clickedRelativePosition {
    CGFloat targetWidth = [self getIndicatorLineViewWidth:cellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = cellFrame.origin.x + (cellFrame.size.width - targetWidth)/2.0;
    toFrame.size.width = targetWidth;
    
    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        self.frame = toFrame;
    }
}

# pragma mark - Private
- (CGFloat)getIndicatorLineViewCornerRadius {
    if (self.indicatorLineViewCornerRadius == kOCFAutomaticDimension) {
        return self.indicatorLineViewHeight/2;
    }
    return self.indicatorLineViewCornerRadius;
}

- (CGFloat)getIndicatorLineViewWidth:(CGRect)cellFrame {
    if (self.indicatorLineWidth == kOCFAutomaticDimension) {
        return cellFrame.size.width;
    }
    return self.indicatorLineWidth;
}

@end

