//
//  OCFNormalCollectionCell.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFNormalCollectionCell.h"
#import <SDWebImage/SDWebImage.h>
#import "OCFFunction.h"
#import "OCFBorderLayer.h"
#import "UIFont+OCFrame.h"
#import "UIImage+OCFrame.h"
#import "NSURL+OCFrame.h"
#import "UIView+OCFrame.h"
#import "OCFNormalCollectionItem.h"
#import "UIImageView+OCFrame.h"
#import "UIColor+OCFrame.h"

@interface OCFNormalCollectionCell ()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *detailLabel;
@property (nonatomic, strong, readwrite) UIImageView *iconImageView;
@property (nonatomic, strong, readwrite) UIImageView *indicatorImageView;
@property (nonatomic, strong, readwrite) OCFNormalCollectionItem *reactor;

@end

@implementation OCFNormalCollectionCell
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.indicatorImageView];
        self.ocf_borderLayer.borderPosition = OCFBorderPositionBottom;
        self.ocf_borderLayer.borderInsets = @{@(OCFBorderPositionBottom): NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 15, 0, 0))};
    }
    return self;
}

#pragma mark - View
#pragma mark - Property
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(15);
        label.textColor = UIColor.ocf_title;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(13);
        label.textColor = UIColor.ocf_body;
        _detailLabel = label;
    }
    return _detailLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sizeToFit];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UIImageView *)indicatorImageView {
    if (!_indicatorImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage.ocf_indicator imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView.tintColor = UIColor.ocf_indicator;
        [imageView sizeToFit];
        _indicatorImageView = imageView;
    }
    return _indicatorImageView;
}

#pragma mark - Method
- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.layer.frame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.iconImageView.isHidden) {
        self.iconImageView.frame = CGRectZero;
        self.iconImageView.qmui_left = 15;
        self.iconImageView.qmui_top = self.iconImageView.qmui_topWhenCenterInSuperview;
        self.titleLabel.qmui_left = self.iconImageView.qmui_left;
    } else {
        self.iconImageView.qmui_height = flat(self.contentView.qmui_height * 0.42);
        self.iconImageView.qmui_width = self.iconImageView.qmui_height;
        self.iconImageView.qmui_left = 15;
        self.iconImageView.qmui_top = self.iconImageView.qmui_topWhenCenterInSuperview;
        self.titleLabel.qmui_left = self.iconImageView.qmui_right + 8;
    }
    self.titleLabel.qmui_top = self.titleLabel.qmui_topWhenCenterInSuperview;
    
    self.indicatorImageView.qmui_right = self.contentView.qmui_width - 15;
    self.indicatorImageView.qmui_top = self.indicatorImageView.qmui_topWhenCenterInSuperview;
    
    self.detailLabel.qmui_right = self.indicatorImageView.qmui_left - 5;
    if (self.indicatorImageView.hidden) {
        self.detailLabel.qmui_right += self.indicatorImageView.qmui_width;
    }
    self.detailLabel.qmui_top = self.detailLabel.qmui_topWhenCenterInSuperview;
}

- (void)bind:(OCFNormalCollectionItem *)reactor {
    self.titleLabel.hidden = (reactor.model.title.length == 0);
    self.titleLabel.text = reactor.model.title;
    [self.titleLabel sizeToFit];
    self.detailLabel.hidden = (reactor.model.detail.length == 0);
    self.detailLabel.text = reactor.model.detail;
    [self.detailLabel sizeToFit];
    self.iconImageView.hidden = ![self.iconImageView ocf_setImageWithSource:reactor.model.icon];
    [super bind:reactor];
}

#pragma mark - Delegate
#pragma mark - Class
+ (Class)layerClass {
    return OCFBorderLayer.class;
}

+ (CGSize)ocf_sizeWithMaxWidth:(CGFloat)maxWidth reactor:(OCFCollectionItem *)reactor {
    return CGSizeMake(maxWidth, OCFMetric(50));
}

@end
