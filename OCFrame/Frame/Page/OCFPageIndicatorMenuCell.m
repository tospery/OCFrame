//
//  OCFPageIndicatorMenuCell.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorMenuCell.h"
#import "OCFPageIndicatorMenuCellModel.h"

@interface OCFPageIndicatorMenuCell ()
@property (nonatomic, strong) UIView *separatorLine;

@end

@implementation OCFPageIndicatorMenuCell

- (void)initializeViews {
    [super initializeViews];
    
    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.hidden = YES;
    [self.contentView addSubview:self.separatorLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    OCFPageIndicatorMenuCellModel *model = (OCFPageIndicatorMenuCellModel *)self.cellModel;
    CGFloat lineWidth = model.separatorLineSize.width;
    CGFloat lineHeight = model.separatorLineSize.height;
    
    self.separatorLine.frame = CGRectMake(self.bounds.size.width - lineWidth + self.cellModel.cellSpacing/2, (self.bounds.size.height - lineHeight)/2.0, lineWidth, lineHeight);
}

- (void)reloadData:(OCFPageBaseMenuCellModel *)cellModel {
    [super reloadData:cellModel];
    
    OCFPageIndicatorMenuCellModel *model = (OCFPageIndicatorMenuCellModel *)cellModel;
    self.separatorLine.backgroundColor = model.separatorLineColor;
    self.separatorLine.hidden = !model.sepratorLineShowEnabled;
    
    if (model.cellBackgroundColorGradientEnabled) {
        if (model.selected) {
            self.contentView.backgroundColor = model.cellBackgroundSelectedColor;
        }else {
            self.contentView.backgroundColor = model.cellBackgroundUnselectedColor;
        }
    }
}

@end

