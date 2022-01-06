//
//  OCFPageTitleMenuCell.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageTitleMenuCell.h"
#import "OCFPageTitleMenuCellModel.h"

@interface OCFPageTitleMenuCell ()
@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation OCFPageTitleMenuCell

- (void)initializeViews {
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    _maskTitleLabel = [[UILabel alloc] init];
    _maskTitleLabel.hidden = YES;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];
    
    _maskLayer = [CALayer layer];
    self.maskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = self.contentView.center;
    self.maskTitleLabel.center = self.contentView.center;
}

- (void)reloadData:(OCFPageBaseMenuCellModel *)cellModel {
    [super reloadData:cellModel];
    
    OCFPageTitleMenuCellModel *myCellModel = (OCFPageTitleMenuCellModel *)cellModel;
    
    CGFloat pointSize = myCellModel.titleFont.pointSize;
    UIFontDescriptor *fontDescriptor = myCellModel.titleFont.fontDescriptor;
    if (myCellModel.selected) {
        fontDescriptor = myCellModel.titleSelectedFont.fontDescriptor;
        pointSize = myCellModel.titleSelectedFont.pointSize;
    }
    if (myCellModel.titleLabelZoomEnabled) {
        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
        self.maskTitleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
    }else {
        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
        self.maskTitleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
    }
    
    self.maskTitleLabel.hidden = !myCellModel.titleLabelMaskEnabled;
    if (myCellModel.titleLabelMaskEnabled) {
        self.titleLabel.textColor = myCellModel.titleColor;
        self.maskTitleLabel.font = myCellModel.titleFont;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;
        
        self.maskTitleLabel.text = [myCellModel.title description];
        [self.maskTitleLabel sizeToFit];
        
        CGRect frame = myCellModel.backgroundViewMaskFrame;
        frame.origin.x -= (self.contentView.bounds.size.width - self.maskTitleLabel.bounds.size.width)/2;
        frame.origin.y = 0;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.maskLayer.frame = frame;
        [CATransaction commit];
    }else {
        if (myCellModel.selected) {
            self.titleLabel.textColor = myCellModel.titleSelectedColor;
        }else {
            self.titleLabel.textColor = myCellModel.titleColor;
        }
    }
    
    self.titleLabel.text = [myCellModel.title description];
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
