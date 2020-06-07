//
//  OCFNormalCollectionCell.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFNormalCollectionCell.h"
#import <SDWebImage/SDWebImage.h>
#import <DKNightVersion/DKNightVersion.h>
#import "OCFFunction.h"
#import "OCFBorderLayer.h"
#import "UIFont+OCFrame.h"
#import "UIImage+OCFrame.h"
#import "NSURL+OCFrame.h"
#import "UIView+OCFrame.h"
#import "OCFNormalCollectionReactor.h"

@interface OCFNormalCollectionCell ()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *detailLabel;
@property (nonatomic, strong, readwrite) UIImageView *avatarImageView;
@property (nonatomic, strong, readwrite) UIImageView *arrowImageView;
@property (nonatomic, strong, readwrite) OCFNormalCollectionReactor *reactor;

@end

@implementation OCFNormalCollectionCell
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.arrowImageView];
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
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(13);
        label.dk_textColorPicker = DKColorPickerWithKey(BODY);
        _detailLabel = label;
    }
    return _detailLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sizeToFit];
        _avatarImageView = imageView;
    }
    return _avatarImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage.ocf_indicator imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView.dk_tintColorPicker = DKColorPickerWithKey(IND);
        [imageView sizeToFit];
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}

#pragma mark - Method
- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    self.layer.frame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.qmui_left = 15;
    self.titleLabel.qmui_top = self.titleLabel.qmui_topWhenCenterInSuperview;
    
    self.arrowImageView.qmui_right = self.contentView.qmui_width - 15;
    self.arrowImageView.qmui_top = self.arrowImageView.qmui_topWhenCenterInSuperview;
    
    self.detailLabel.qmui_right = self.arrowImageView.qmui_left - 6;
    if (self.arrowImageView.hidden) {
        self.detailLabel.qmui_right += self.arrowImageView.qmui_width;
    }
    self.detailLabel.qmui_top = self.detailLabel.qmui_topWhenCenterInSuperview;
    
    self.avatarImageView.qmui_height = flat(self.contentView.qmui_height * 0.6);
    self.avatarImageView.qmui_width = self.avatarImageView.qmui_height;
    self.avatarImageView.qmui_right = self.detailLabel.qmui_left - 8;
    self.avatarImageView.qmui_top = self.avatarImageView.qmui_topWhenCenterInSuperview;
    self.avatarImageView.ocf_cornerRadius = flat(self.avatarImageView.qmui_height / 2.0f);
}

- (void)bind:(OCFNormalCollectionReactor *)reactor {
    self.titleLabel.hidden = (reactor.model.title.length == 0);
    self.titleLabel.text = reactor.model.title;
    [self.titleLabel sizeToFit];
    self.detailLabel.hidden = (reactor.model.detail.length == 0);
    self.detailLabel.text = reactor.model.detail;
    [self.detailLabel sizeToFit];
    self.avatarImageView.hidden = (reactor.model.avatar.length == 0);
    [self.avatarImageView sd_setImageWithURL:OCFURLWithStr(reactor.model.avatar)];
    [self.avatarImageView sizeToFit];
    [super bind:reactor];
}

#pragma mark - Delegate
#pragma mark - Class
+ (Class)layerClass {
    return OCFBorderLayer.class;
}

@end
