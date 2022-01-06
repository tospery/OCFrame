//
//  OCFPageIndicatorComponentView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorComponentView.h"

@interface OCFPageIndicatorComponentView ()

@end

@implementation OCFPageIndicatorComponentView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _componentPosition = OCFPageComponentPositionBottom;
        _scrollEnabled = YES;
        _verticalMargin = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        NSAssert(NO, @"Use initWithFrame");
    }
    return self;
}

#pragma mark - OCFPageIndicatorProtocol

- (void)refreshState:(CGRect)selectedCellFrame {
    
}

- (void)contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(OCFPageCellClickedPosition)selectedPosition percent:(CGFloat)percent {
    
}

- (void)selectedCell:(CGRect)cellFrame clickedRelativePosition:(OCFPageCellClickedPosition)clickedRelativePosition {
    
}

@end
