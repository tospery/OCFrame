//
//  OCFScrollViewController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollViewController.h"
#import <Mantle/Mantle.h>
#import <MJRefresh/MJRefresh.h>
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFrameManager.h"
#import "OCFAppDependency.h"
#import "OCFWebViewController.h"
#import "OCFLoginViewController.h"
#import "OCFCollectionViewController.h"
#import "NSError+OCFrame.h"
#import "NSURL+OCFrame.h"
#import "UIScrollView+OCFrame.h"
#import "UIColor+OCFrame.h"

@interface OCFScrollViewController ()
@property (nonatomic, assign, readwrite) CGFloat lastPosition;
@property (nonatomic, assign, readwrite) OCFScrollDirection scrollDirection;
@property (nonatomic, strong, readwrite) OCFScrollViewReactor *reactor;

@end

@implementation OCFScrollViewController
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithReactor:(OCFViewReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super initWithReactor:reactor navigator:navigator]) {
    }
    return self;
}

- (void)dealloc {
    _scrollView.delegate = nil;
    _scrollView.emptyDataSetSource = nil;
    _scrollView.emptyDataSetDelegate = nil;
    _scrollView = nil;
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isKindOfClass:OCFCollectionViewController.class]) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.contentFrame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        self.scrollView = collectionView;
    } else {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentFrame];
        scrollView.ocf_contentView = [[UIView alloc] init];
        scrollView.ocf_contentView.backgroundColor = UIColor.clearColor;
        scrollView.ocf_contentView.frame = scrollView.bounds;
        scrollView.contentSize = CGSizeMake(scrollView.qmui_width, scrollView.qmui_height + PixelOne);
        scrollView.delegate = self;
    }
    self.scrollView.backgroundColor = UIColor.ocf_background;
    self.scrollView.emptyDataSetSource = self.reactor;
    self.scrollView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.scrollView];
    
    OCFLogDebug(@"scrollView frame = %@", NSStringFromCGRect(self.scrollView.frame));
    
//    if (![self isKindOfClass:OCFCollectionViewController.class] /*&&
//        ![self isKindOfClass:OCFWebViewController.class]*/) {
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.contentFrame];
//        scrollView.ocf_contentView = [[UIView alloc] init];
//        scrollView.ocf_contentView.frame = scrollView.bounds;
//        scrollView.ocf_contentView.theme_backgroundColor = ThemeColorPicker.background;
//        scrollView.contentSize = CGSizeMake(scrollView.qmui_width, scrollView.qmui_height + PixelOne);
//        scrollView.theme_backgroundColor = ThemeColorPicker.background;
//        scrollView.delegate = self;
//        scrollView.emptyDataSetSource = self.reactor;
//        scrollView.emptyDataSetDelegate = self;
//        if (@available(iOS 11.0, *)) {
//            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//        [self.view addSubview:scrollView];
//        self.scrollView = scrollView;
//    }
}

#pragma mark - Property

#pragma mark - Bind
- (void)bind:(OCFBaseReactor *)reactor {
    [super bind:reactor];
    @weakify(self)
    [RACObserve(self.reactor, shouldPullToRefresh).distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *should) {
        @strongify(self)
        [self setupRefresh:should.boolValue];
    }];
    [RACObserve(self.reactor, shouldScrollToMore).distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *should) {
        @strongify(self)
        [self setupMore:should.boolValue];
    }];
    
////    [self.reactor.errors doNext:^(id x) {
////        NSLog(@"");
////    }];
//    [self.reactor.errors subscribeNext:^(id  _Nullable x) {
//        NSLog(@"");
//    }];
}

- (void)reloadData {
    [super reloadData];
    if ([self.scrollView isMemberOfClass:UIScrollView.class]) {
        [self.scrollView reloadEmptyDataSet];
    }
}

- (BOOL)handleError {
    BOOL handled = NO;
    if (!self.reactor.error) {
        return handled;
    }
    
    OCFRequestMode requestMode = self.reactor.requestMode;
    self.reactor.requestMode = OCFRequestModeNone;
    
    handled = YES;
    switch (requestMode) {
        case OCFRequestModeNone: {
            if (self.reactor.user.isLogined) {
                [self triggerLoad];
            } else {
                if (OCFErrorCodeNotLoginedIn != self.reactor.error.code) {
                    [self triggerLoad];
                }
            }
            break;
        }
        case OCFRequestModeLoad: {
            [self reloadData];
            break;
        }
        case OCFRequestModeRefresh: {
            [self.scrollView.mj_header endRefreshing];
            @weakify(self)
            [RACScheduler.currentScheduler afterDelay:1 schedule:^{
                @strongify(self)
                [self setupRefresh:NO];
            }];
            [self setupMore:NO];
            self.reactor.dataSource = nil;
            break;
        }
        case OCFRequestModeMore: {
            handled = NO;
            [self.scrollView.mj_footer endRefreshing];
//            if (OCFErrorCodeUnauthorized == self.reactor.error.code) {
//                @weakify(self)
//                [RACScheduler.mainThreadScheduler afterDelay:1 schedule:^{
//                    @strongify(self)
//                    [self setupMore:NO];
//                }];
//                [self setupRefresh:NO];
//                self.reactor.dataSource = nil;
//            } else {
//                handled = NO;
//            }
            break;
        }
        default: {
            break;
        }
    }
    
    if (OCFErrorCodeNotLoginedIn == self.reactor.error.code) {
        if (self.reactor.user.isLogined) {
            [self.reactor.user logout];
        }
        if (OCFrameManager.sharedInstance.autoLogin &&
            ![UIViewController.ocf_topMostViewController isKindOfClass:OCFLoginViewController.class]) {
            [self.navigator routeURL:OCFURLWithHostpath(OCFrameManager.sharedInstance.loginPattern) withParameters:nil];
        }
    }
    
    return handled;
}

#pragma mark - Load
- (void)beginLoad {
    [super beginLoad];
    [self setupRefresh:NO];
    [self setupMore:NO];
}

- (void)triggerLoad {
    [self beginLoad];
    @weakify(self)
    [[self.reactor.requestRemoteCommand execute:@(self.reactor.page.start)].deliverOnMainThread subscribeNext:^(id data) {
        @strongify(self)
        self.reactor.page.index = self.reactor.page.start;
    } completed:^{
        @strongify(self)
        [self endLoad];
    }];
}

- (void)endLoad {
    [super endLoad];
    if (self.reactor.shouldPullToRefresh) {
        [self setupRefresh:YES];
    }
    if (self.reactor.shouldScrollToMore) {
        [self setupMore:YES];
        if (!self.reactor.hasMoreData) {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

#pragma mark - Refresh
- (void)setupRefresh:(BOOL)enable {
    if (enable) {
        self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(triggerRefresh)];
    }else {
        [self.scrollView.mj_header removeFromSuperview];
        self.scrollView.mj_header = nil;
    }
}

- (void)beginRefresh {
    self.reactor.requestMode = OCFRequestModeRefresh;
    if (self.reactor.error) {
        self.reactor.error = nil;
    }
}

- (void)triggerRefresh {
    [self beginRefresh];
    @weakify(self)
    [[self.reactor.requestRemoteCommand execute:@(self.reactor.page.start)].deliverOnMainThread subscribeNext:^(id data) {
        @strongify(self)
        self.reactor.page.index = self.reactor.page.start;
    } completed:^{
        @strongify(self)
        [self endRefresh];
    }];
}

- (void)endRefresh {
    self.reactor.requestMode = OCFRequestModeNone;
    [self.scrollView.mj_header endRefreshing];
    if (self.reactor.shouldScrollToMore) {
        if (self.reactor.hasMoreData) {
            [self.scrollView.mj_footer resetNoMoreData];
        } else {
            [self.scrollView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}

#pragma mark - More
- (void)setupMore:(BOOL)enable {
    if (enable) {
        self.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(triggerMore)];
    }else {
        [self.scrollView.mj_footer removeFromSuperview];
        self.scrollView.mj_footer = nil;
    }
}

- (void)beginMore {
    self.reactor.requestMode = OCFRequestModeMore;
}

- (void)triggerMore {
    [self beginMore];
    @weakify(self)
    NSInteger pageIndex = [self.reactor nextPageIndex];
    [[self.reactor.requestRemoteCommand execute:@(pageIndex)].deliverOnMainThread subscribeNext:^(id data) {
        @strongify(self)
        self.reactor.page.index = pageIndex;
    } completed:^{
        @strongify(self)
        [self endMore];
    }];
}

- (void)endMore {
    self.reactor.requestMode = OCFRequestModeNone;
    if (self.reactor.hasMoreData) {
        [self.scrollView.mj_footer endRefreshing];
    }else {
        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - Delegate
#pragma mark DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return (self.reactor.shouldRequestRemoteData && !self.reactor.dataSource);
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return !self.reactor.error;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self handleError];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self handleError];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentPostion = scrollView.contentOffset.y;
    CGFloat offset = currentPostion - self.lastPosition;
    if (offset > 0) {
        self.scrollDirection = OCFScrollDirectionUp;
    } else if (offset < 0) {
        self.scrollDirection = OCFScrollDirectionDown;
    } else {
        self.scrollDirection = OCFScrollDirectionNone;
    }
    self.lastPosition = currentPostion;
}

#pragma mark - Class

@end
