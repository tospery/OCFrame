//
//  OCFCollectionCell.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionCell.h"
//#import <DKNightVersion/DKNightVersion.h>
#import "OCFFunction.h"

@interface OCFCollectionCell ()
@property (nonatomic, strong, readwrite) OCFCollectionReactor *reactor;

@end

@implementation OCFCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.reactor) {
        return;
    }
}

- (void)bind:(OCFCollectionReactor *)reactor {
    self.reactor = reactor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
