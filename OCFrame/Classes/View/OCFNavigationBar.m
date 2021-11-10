//
//  OCFNavigationBar.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFNavigationBar.h"
#import "OCFFunction.h"
#import "UIFont+OCFrame.h"
#import "UIImage+OCFrame.h"
#import "UIView+OCFrame.h"
#import "ThemeColorPicker+OCFrame.h"

@interface OCFNavigationBar ()
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UIImageView *bgImageView;
@property (nonatomic, strong, readwrite) UIButton *backButton;
@property (nonatomic, strong, readwrite) UIButton *closeButton;
@property (nonatomic, strong, readwrite) NSArray *leftButtons;
@property (nonatomic, strong, readwrite) NSArray *rightButtons;
@property (nonatomic, assign) QMUIViewBorderPosition borderPosition;

@end

@implementation OCFNavigationBar
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.theme_backgroundColor = ThemeColorPicker.background;
        
        self.borderPosition = QMUIViewBorderPositionBottom;
        self.qmui_borderPosition = self.borderPosition;
        self.qmui_borderWidth = PixelOne;
        // self.dk_borderColorPicker = DKColorPickerWithKey(SEP);

        [self addSubview:self.bgImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - View
#pragma mark - Property
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = OCFFont(17);
        label.backgroundColor = UIColorClear;
        label.textAlignment = NSTextAlignmentCenter;
        label.theme_textColor = ThemeColorPicker.title;
        [label sizeToFit];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = UIColorClear;
        [imageView sizeToFit];
        _bgImageView = imageView;
    }
    return _bgImageView;
}

#pragma mark - Method
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(DEVICE_WIDTH, NavigationContentTopConstant);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    
    CGFloat left = 0;
    CGFloat top = StatusBarHeightConstant;
    CGFloat width = NavigationBarHeight;
    CGFloat height = width;
    for (NSInteger i = 0; i < self.leftButtons.count; ++i) {
        UIButton *button = self.leftButtons[i];
        button.qmui_width = width;
        button.qmui_height = height;
        button.qmui_top = top;
        button.qmui_left = left;
        left += button.qmui_width;
    }
    CGFloat right = self.qmui_width;
    for (NSInteger i = 0; i < self.rightButtons.count; ++i) {
        UIButton *button = self.rightButtons[i];
        button.qmui_width = width;
        button.qmui_height = height;
        button.qmui_top = top;
        button.qmui_right = right;
        right -= button.qmui_width;
    }
    
    UIButton *leftLastButton = self.leftButtons.lastObject;
    CGFloat leftDistance = leftLastButton ? leftLastButton.qmui_right : 0;
    UIButton *rightLastButton = self.rightButtons.lastObject;
    CGFloat rightDistance = rightLastButton ? (self.qmui_width - rightLastButton.qmui_left) : 0;
    left = MAX(leftDistance, rightDistance);
    width = flat(self.qmui_width - left * 2);
    self.titleLabel.frame = CGRectMake(left, StatusBarHeightConstant, width, NavigationBarHeight);
}

- (UIButton *)addBackButtonToLeft {
    return [self addButtonToLeftWithImage:UIImage.ocf_back];
}

- (UIButton *)addCloseButtonToLeft {
    return [self addButtonToLeftWithImage:UIImage.ocf_close];
}

- (UIButton *)addButtonToLeftWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorClear;
    button.theme_tintColor = ThemeColorPicker.barText;
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [button sizeToFit];
    [self addSubview:button];
    
    NSMutableArray *leftButtons = [NSMutableArray arrayWithArray:self.leftButtons];
    [leftButtons addObject:button];
    self.leftButtons = leftButtons;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return button;
}

- (UIButton *)addButtonToRightWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorClear;
    button.theme_tintColor = ThemeColorPicker.barText;
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [button sizeToFit];
    [self addSubview:button];
    
    NSMutableArray *rightButtons = [NSMutableArray arrayWithArray:self.rightButtons];
    [rightButtons addObject:button];
    self.rightButtons = rightButtons;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return button;
}

- (UIButton *)addButtonToRightWithTitle:(NSAttributedString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorClear;
    [button setAttributedTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    [self addSubview:button];
    
    NSMutableArray *rightButtons = [NSMutableArray arrayWithArray:self.rightButtons];
    [rightButtons addObject:button];
    self.rightButtons = rightButtons;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    return button;
}

- (void)transparet {
    self.borderPosition = self.qmui_borderPosition;
    self.backgroundColor = UIColorClear;
    self.qmui_borderPosition = QMUIViewBorderPositionNone;
}

- (void)reset {
    self.theme_backgroundColor = ThemeColorPicker.background;
    self.qmui_borderPosition = self.borderPosition;
}

#pragma mark - Delegate
#pragma mark - Class

@end
