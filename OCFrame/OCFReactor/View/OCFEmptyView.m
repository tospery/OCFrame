//
//  OCFEmptyView.m
//  OCFrame
//
//  Created by 杨建祥 on 2021/12/25.
//

#import "OCFEmptyView.h"
#import <QMUIKit/QMUIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <OCFrame/OCFExtensions.h>
#import "OCFEmptyReactor.h"

@interface OCFEmptyView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong, readwrite) OCFEmptyReactor *reactor;

@end

@implementation OCFEmptyView
@dynamic reactor;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.ocf_background;
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (void)dealloc {
    OCFLogDebug(@"OCFEmptyView已回收");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.messageLabel sizeToFit];
    self.messageLabel.qmui_width = MIN(self.messageLabel.qmui_width, self.qmui_width);
    self.messageLabel.qmui_left = self.messageLabel.qmui_leftWhenCenterInSuperview;
    self.messageLabel.qmui_top = flat(self.messageLabel.qmui_topWhenCenterInSuperview * 0.8);
    [self.titleLabel sizeToFit];
    self.titleLabel.qmui_width = MIN(self.titleLabel.qmui_width, self.qmui_width);
    self.titleLabel.qmui_left = self.titleLabel.qmui_leftWhenCenterInSuperview;
    self.titleLabel.qmui_bottom = self.messageLabel.qmui_top - 15;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(18);
        label.textColor = UIColor.ocf_title;
        [label sizeToFit];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(15);
        label.textColor = UIColor.ocf_body;
        [label sizeToFit];
        _messageLabel = label;
    }
    return _messageLabel;
}

- (void)bind:(OCFEmptyReactor *)reactor {
    self.reactor = reactor;
    RAC(self, hidden) = [RACObserve(reactor, error).distinctUntilChanged map:^NSNumber *(NSError *error) {
        return @(error == nil || error.ocf_isCancelled);
    }].distinctUntilChanged;
    RAC(self.titleLabel, text) = RACObserve(reactor, error.localizedFailureReason).distinctUntilChanged;
    RAC(self.messageLabel, text) = RACObserve(reactor, error.localizedDescription).distinctUntilChanged;
    
    NSArray *layouts = @[
        RACObserve(self, hidden).distinctUntilChanged,
        RACObserve(self.titleLabel, text).distinctUntilChanged,
        RACObserve(self.messageLabel, text).distinctUntilChanged
    ];
    @weakify(self)
    [[[RACSignal merge:layouts] skip:layouts.count] subscribeNext:^(id x) {
        @strongify(self)
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
