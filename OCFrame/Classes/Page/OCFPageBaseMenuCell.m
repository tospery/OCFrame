//
//  OCFPageBaseMenuCell.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageBaseMenuCell.h"

@interface OCFPageBaseMenuCell ()

@end

@implementation OCFPageBaseMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
}

- (void)reloadData:(OCFPageBaseMenuCellModel *)cellModel {
    self.cellModel = cellModel;
}

@end
