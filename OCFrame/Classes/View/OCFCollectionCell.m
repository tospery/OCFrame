//
//  OCFCollectionCell.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionCell.h"
#import "OCFFunction.h"
#import "ThemeColorPicker+OCFrame.h"

@interface OCFCollectionCell ()
@property (nonatomic, strong, readwrite) OCFCollectionItem *reactor;

@end

@implementation OCFCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.theme_backgroundColor = ThemeColorPicker.background;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.reactor) {
        return;
    }
}

- (void)bind:(OCFCollectionItem *)reactor {
    self.reactor = reactor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
