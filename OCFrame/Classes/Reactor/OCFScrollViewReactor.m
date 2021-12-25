//
//  OCFScrollViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollViewReactor.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFParameter.h"
#import "OCFrameManager.h"
#import "OCFAppDependency.h"
#import "OCFLoginViewController.h"
#import "NSDictionary+OCFrame.h"
#import "NSError+OCFrame.h"
#import "NSAttributedString+OCFrame.h"
#import "UIFont+OCFrame.h"
#import "UIImage+OCFrame.h"
#import "UIColor+OCFrame.h"
#import "OCFScrollItem.h"

@interface OCFScrollViewReactor ()
@property (nonatomic, strong, readwrite) OCFPage *page;
@property (nonatomic, strong, readwrite) RACCommand *selectCommand;

@end

@implementation OCFScrollViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
        self.shouldPullToRefresh = OCFBoolMember(parameters, OCFParameter.pullRefresh, NO);
        self.shouldScrollToMore = OCFBoolMember(parameters, OCFParameter.scrollMore, NO);
        self.page = [[OCFPage alloc] init];
        self.page.start = OCFIntMember(parameters, OCFParameter.page, OCFrameManager.sharedInstance.page.start);
        self.page.size = OCFIntMember(parameters, OCFParameter.pageSize, OCFrameManager.sharedInstance.page.size);
    }
    return self;
}

- (void)didInit {
    [super didInit];
}

#pragma mark - Property
- (RACCommand *)selectCommand {
    if (!_selectCommand) {
        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal return:input];
        }];
        [[command.executionSignals.switchToLatest flattenMap:^RACSignal *(RACTuple *tuple) {
            if (![tuple.second isKindOfClass:OCFScrollItem.class]) {
                return [RACSignal return:tuple];
            }
            OCFScrollItem *item = (OCFScrollItem *)tuple.second;
            NSString *target = item.target;
            if (target.length == 0) {
                return [RACSignal return:tuple];
            }
            return [RACSignal return:target];
        }] subscribe:self.navigate];
        _selectCommand = command;
    }
    return _selectCommand;
}

#pragma mark - Page
- (NSInteger)offsetForPage:(NSInteger)page {
    return (page - 1) * self.page.size;
}

- (NSInteger)nextPageIndex {
    return self.page.index + 1;
}

#pragma mark - Delegate
#pragma mark DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.error) {
        return nil;
    }
    return [NSAttributedString ocf_attributedStringWithString:self.error.localizedFailureReason color:UIColor.ocf_title font:OCFFont(16.0f)];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.error) {
        return nil;
    }
    return [NSAttributedString ocf_attributedStringWithString:self.error.localizedDescription color:UIColor.ocf_body font:OCFFont(14.0f)];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (!self.error) {
        return nil;
    }
    return [NSAttributedString ocf_attributedStringWithString:self.error.localizedRecoverySuggestion color:(UIControlStateNormal == state ? UIColorWhite : [UIColorWhite colorWithAlphaComponent:0.8]) font:OCFFont(15.0f)];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    UIImage *image = [UIImage qmui_imageWithColor:UIColor.ocf_primary size:CGSizeMake(120, 30) cornerRadius:2.0f];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(0, -120, 0, -120)];
    return (UIControlStateNormal == state ? image : nil);
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.error) {
        return [UIImage.ocf_loading qmui_imageWithTintColor:UIColor.ocf_primary];
    }
    return self.error.ocf_displayImage;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    return animation;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return UIColor.ocf_background;
}

#pragma mark - Class

@end
