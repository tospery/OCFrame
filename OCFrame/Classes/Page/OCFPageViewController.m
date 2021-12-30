//
//  OCFPageViewController.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageViewController.h"
#import "OCFPageFactory.h"
#import "OCFPageViewReactor.h"
#import "OCFPageTitleMenuView.h"

@interface OCFPageViewController () {
    BOOL    _hasInited, _shouldNotScroll;
    NSInteger _initializedIndex, _controllerCount, _markedSelectIndex;
    CGFloat _targetX;
    CGRect  _contentViewFrame, _menuViewFrame;
}
@property (nonatomic, strong, readwrite) OCFPageViewReactor *reactor;

// 用于记录子控制器view的frame，用于 scrollView 上的展示的位置
@property (nonatomic, strong) NSMutableArray *childViewFrames;
// 当前展示在屏幕上的控制器，方便在滚动的时候读取 (避免不必要计算)
@property (nonatomic, strong) NSMutableDictionary *displayVC;
// 用于记录销毁的viewController的位置 (如果它是某一种scrollView的Controller的话)
@property (nonatomic, strong) NSMutableDictionary *posRecords;
// 用于缓存加载过的控制器
@property (nonatomic, strong) NSCache *memCache;
@property (nonatomic, strong) NSMutableDictionary *backgroundCache;
// 收到内存警告的次数
@property (nonatomic, assign) int memoryWarningCount;

@property (nonatomic, assign, readonly) NSInteger childControllersCount;

@property (nonatomic, strong, readwrite) UIViewController *currentViewController;

@end

@implementation OCFPageViewController
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithReactor:(OCFViewReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super initWithReactor:reactor navigator:navigator]) {
        _selectIndex = self.reactor.selectIndex;
        [self pv_setup];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [self pv_setup];
//    }
//    return self;
//}
//
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        [self pv_setup];
//    }
//    return self;
//}
//
//- (instancetype)initWithViewControllerClasses:(NSArray<Class> *)classes andTheirTitles:(NSArray<NSString *> *)titles {
//    if (self = [self initWithNibName:nil bundle:nil]) {
//        NSParameterAssert(classes.count == titles.count);
//        _viewControllerClasses = [NSArray arrayWithArray:classes];
//        _titles = [NSArray arrayWithArray:titles];
//    }
//    return self;
//}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (!self.childControllersCount) {
        return;
    }
    
    [self pv_calculateSize];
    [self pv_addScrollView];
    [self pv_initializedControllerWithIndexIfNeeded:self.selectIndex];
    self.currentViewController = self.displayVC[@(self.selectIndex)];
    [self pv_addMenuView];
    [self didEnterController:self.currentViewController atIndex:self.selectIndex];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (!self.childControllersCount) {
        return;
    }
    
    _hasInited = YES;
    [self forceLayoutSubviews];
    [self pv_delaySelectIndexIfNeeded];
}

#pragma mark - Super
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.memoryWarningCount++;
    self.cachePolicy = OCFPageCachePolicyLowMemory;
    // 取消正在增长的 cache 操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyAfterMemoryWarning) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyToHigh) object:nil];
    
    [self.memCache removeAllObjects];
    [self.posRecords removeAllObjects];
    self.posRecords = nil;
    
    // 如果收到内存警告次数小于 3，一段时间后切换到模式 Balanced
    if (self.memoryWarningCount < 3) {
        [self performSelector:@selector(pv_growCachePolicyAfterMemoryWarning) withObject:nil afterDelay:3.0 inModes:@[NSRunLoopCommonModes]];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyAfterMemoryWarning) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyToHigh) object:nil];
}

#pragma mark - Accessor
#pragma mark get
- (NSMutableDictionary *)posRecords {
    if (_posRecords == nil) {
        _posRecords = [[NSMutableDictionary alloc] init];
    }
    return _posRecords;
}

- (NSMutableDictionary *)displayVC {
    if (_displayVC == nil) {
        _displayVC = [[NSMutableDictionary alloc] init];
    }
    return _displayVC;
}

- (NSMutableDictionary *)backgroundCache {
    if (_backgroundCache == nil) {
        _backgroundCache = [[NSMutableDictionary alloc] init];
    }
    return _backgroundCache;
}

#pragma mark set
- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    
    if (!self.pageScrollView) return;
    self.pageScrollView.scrollEnabled = scrollEnable;
}

- (void)setProgressViewCornerRadius:(CGFloat)progressViewCornerRadius {
    _progressViewCornerRadius = progressViewCornerRadius;
    //    if (self.menuView) {
    //        self.menuView.progressViewCornerRadius = progressViewCornerRadius;
    //    }
}

- (void)setMenuViewLayout:(OCFPageMenuViewLayout)menuViewLayout {
    _menuViewLayout = menuViewLayout;
    if (self.menuView.superview) {
        [self pv_resetMenuView];
    }
}

- (void)setCachePolicy:(OCFPageCachePolicy)cachePolicy {
    _cachePolicy = cachePolicy;
    if (cachePolicy != OCFPageCachePolicyDisabled) {
        self.memCache.countLimit = _cachePolicy;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    _markedSelectIndex = kOCFUndefinedInteger;
    if (self.menuView && _hasInited) {
        [self.menuView selectItemAtIndex:selectIndex];
    } else {
        _markedSelectIndex = selectIndex;
        UIViewController *vc = [self.memCache objectForKey:@(selectIndex)];
        if (!vc) {
            vc = [self initializeViewControllerAtIndex:selectIndex];
            [self.memCache setObject:vc forKey:@(selectIndex)];
        }
        self.currentViewController = vc;
    }
}

- (void)setProgressViewIsNaughty:(BOOL)progressViewIsNaughty {
    _progressViewIsNaughty = progressViewIsNaughty;
    if (self.menuView) {
        // self.menuView.progressViewIsNaughty = progressViewIsNaughty;
    }
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.progressViewWidths = ({
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i = 0; i < self.childControllersCount; i++) {
            [tmp addObject:@(progressWidth)];
        }
        tmp.copy;
    });
}

- (void)setProgressViewWidths:(NSArray *)progressViewWidths {
    _progressViewWidths = progressViewWidths;
    if (self.menuView) {
        //self.menuView.progressWidths = progressViewWidths;
    }
}

- (void)setMenuViewContentMargin:(CGFloat)menuViewContentMargin {
    _menuViewContentMargin = menuViewContentMargin;
    if (self.menuView) {
        //self.menuView.contentMargin = menuViewContentMargin;
    }
}

- (void)setShowOnNavigationBar:(BOOL)showOnNavigationBar {
    if (_showOnNavigationBar == showOnNavigationBar) {
        return;
    }
    
    _showOnNavigationBar = showOnNavigationBar;
    if (self.menuView) {
        [self.menuView removeFromSuperview];
        [self pv_addMenuView];
        [self forceLayoutSubviews];
        [self.menuView selectItemAtIndex:self.selectIndex];
    }
}

#pragma mark - Private
#pragma mark pv
- (void)pv_resetScrollView {
    if (self.pageScrollView) {
        [self.pageScrollView removeFromSuperview];
    }
    [self pv_addScrollView];
    [self pv_addViewControllerAtIndex:self.selectIndex];
    self.currentViewController = self.displayVC[@(self.selectIndex)];
}

- (void)pv_clearDatas {
    _controllerCount = kOCFUndefinedInteger;
    _hasInited = NO;
    NSUInteger maxIndex = (self.childControllersCount - 1 > 0) ? (self.childControllersCount - 1) : 0;
    _selectIndex = self.selectIndex < self.childControllersCount ? self.selectIndex : maxIndex;
    if (self.progressWidth > 0) {
        self.progressWidth = self.progressWidth;
    }
    
    NSArray *displayingViewControllers = self.displayVC.allValues;
    for (UIViewController *vc in displayingViewControllers) {
        [vc.view removeFromSuperview];
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    self.memoryWarningCount = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyAfterMemoryWarning) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pv_growCachePolicyToHigh) object:nil];
    self.currentViewController = nil;
    [self.posRecords removeAllObjects];
    [self.displayVC removeAllObjects];
}

// 当子控制器init完成时发送通知
- (void)pv_postAddToSuperViewNotificationWithIndex:(int)index {
    if (!self.postNotification) {
        return;
    }
    
    NSDictionary *info = @{
                           @"index":@(index),
                           @"title":[self titleAtIndex:index]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:kOCFPageViewControllerDidAddToSuperViewNotification
                                                        object:self
                                                      userInfo:info];
}

// 当子控制器完全展示在user面前时发送通知
- (void)pv_postFullyDisplayedNotificationWithCurrentIndex:(NSInteger)index {
    if (!self.postNotification) {
        return;
    }
    
    NSDictionary *info = @{
                           @"index":@(index),
                           @"title":[self titleAtIndex:index]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:kOCFPageViewControllerDidFullyDisplayedNotification
                                                        object:self
                                                      userInfo:info];
}

// 初始化一些参数，在init中调用
- (void)pv_setup {
    _titleSizeSelected  = 18.0f;
    _titleSizeNormal    = 15.0f;
    _titleColorSelected = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    _titleColorNormal   = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    _menuItemWidth = 65.0f;
    
    _memCache = [[NSCache alloc] init];
    _scrollEnable = YES;
    _initializedIndex = kOCFUndefinedInteger;
    _markedSelectIndex = kOCFUndefinedInteger;
    _controllerCount  = kOCFUndefinedInteger;
    _progressViewCornerRadius = kOCFUndefinedInteger;
    _progressHeight = kOCFUndefinedInteger;
    
    self.automaticallyCalculatesItemWidths = NO;
    self.preloadPolicy = OCFPagePreloadPolicyNever;
    self.cachePolicy = OCFPageCachePolicyNoLimit;
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataSource = self;
    self.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

// 包括宽高，子控制器视图 frame
- (void)pv_calculateSize {
    _menuViewFrame = [self.dataSource pageViewController:self preferredFrameForMenuView:self.menuView];
    _contentViewFrame = [self.dataSource pageViewController:self preferredFrameForContentView:self.pageScrollView];
    _childViewFrames = [NSMutableArray array];
    for (int i = 0; i < self.childControllersCount; i++) {
        CGRect frame = CGRectMake(i * _contentViewFrame.size.width, 0, _contentViewFrame.size.width, _contentViewFrame.size.height);
        [_childViewFrames addObject:[NSValue valueWithCGRect:frame]];
    }
}

- (void)pv_addScrollView {
    OCFPageScrollView *scrollView = [[OCFPageScrollView alloc] init];
    scrollView.scrollsToTop = NO;
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = self.bounces;
    scrollView.scrollEnabled = self.scrollEnable;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:scrollView];
    self.pageScrollView = scrollView;
    
    if (!self.navigationController) {
        return;
    }
    
    for (UIGestureRecognizer *gestureRecognizer in scrollView.gestureRecognizers) {
        [gestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    }
}

- (void)pv_addMenuView {
    OCFPageBaseMenuView *menuView = [self.dataSource menuViewForPageViewController:self];
    if (!menuView) {
        return;
    }
    
    menuView.delegate = self;
    menuView.contentScrollView = self.pageScrollView;
    menuView.defaultSelectedIndex = self.selectIndex;
    
    [self.view addSubview:menuView];
    self.menuView = menuView;
}

- (void)pv_layoutChildViewControllers {
    int currentPage = (int)(self.pageScrollView.contentOffset.x / _contentViewFrame.size.width);
    int length = (int)self.preloadPolicy;
    int left = currentPage - length - 1;
    int right = currentPage + length + 1;
    for (int i = 0; i < self.childControllersCount; i++) {
        UIViewController *vc = [self.displayVC objectForKey:@(i)];
        CGRect frame = [self.childViewFrames[i] CGRectValue];
        if (!vc) {
            if ([self pv_isInScreen:frame]) {
                [self pv_initializedControllerWithIndexIfNeeded:i];
            }
        } else if (i <= left || i >= right) {
            if (![self pv_isInScreen:frame]) {
                [self pv_removeViewController:vc atIndex:i];
            }
        }
    }
}

// 创建或从缓存中获取控制器并添加到视图上
- (void)pv_initializedControllerWithIndexIfNeeded:(NSInteger)index {
    // 先从 cache 中取
    UIViewController *vc = [self.memCache objectForKey:@(index)];
    if (vc) {
        // cache 中存在，添加到 scrollView 上，并放入display
        [self pv_addCachedViewController:vc atIndex:index];
    } else {
        // cache 中也不存在，创建并添加到display
        [self pv_addViewControllerAtIndex:(int)index];
    }
    [self pv_postAddToSuperViewNotificationWithIndex:(int)index];
}

- (void)pv_addCachedViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    [self addChildViewController:viewController];
    viewController.view.frame = [self.childViewFrames[index] CGRectValue];
    [viewController didMoveToParentViewController:self];
    [self.pageScrollView addSubview:viewController.view];
    [self willEnterController:viewController atIndex:index];
    [self.displayVC setObject:viewController forKey:@(index)];
}

// 创建并添加子控制器
- (void)pv_addViewControllerAtIndex:(NSInteger)index {
    _initializedIndex = index;
    UIViewController *viewController = [self initializeViewControllerAtIndex:index];
    if (self.values.count == self.childControllersCount && self.keys.count == self.childControllersCount) {
        [viewController setValue:self.values[index] forKey:self.keys[index]];
    }
    [self addChildViewController:viewController];
    CGRect frame = self.childViewFrames.count ? [self.childViewFrames[index] CGRectValue] : self.view.frame;
    viewController.view.frame = frame;
    [viewController didMoveToParentViewController:self];
    [self.pageScrollView addSubview:viewController.view];
    [self willEnterController:viewController atIndex:index];
    [self.displayVC setObject:viewController forKey:@(index)];
    
    [self pv_backToPositionIfNeeded:viewController atIndex:index];
}

// 移除控制器，且从display中移除
- (void)pv_removeViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    [self pv_rememberPositionIfNeeded:viewController atIndex:index];
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
    [self.displayVC removeObjectForKey:@(index)];
    
    // 放入缓存
    if (self.cachePolicy == OCFPageCachePolicyDisabled) {
        return;
    }
    
    if (![self.memCache objectForKey:@(index)]) {
        [self willCachedController:viewController atIndex:index];
        [self.memCache setObject:viewController forKey:@(index)];
    }
}

- (void)pv_backToPositionIfNeeded:(UIViewController *)controller atIndex:(NSInteger)index {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (!self.rememberLocation) return;
#pragma clang diagnostic pop
    if ([self.memCache objectForKey:@(index)]) return;
    UIScrollView *scrollView = [self pv_isKindOfScrollViewController:controller];
    if (scrollView) {
        NSValue *pointValue = self.posRecords[@(index)];
        if (pointValue) {
            CGPoint pos = [pointValue CGPointValue];
            [scrollView setContentOffset:pos];
        }
    }
}

- (void)pv_rememberPositionIfNeeded:(UIViewController *)controller atIndex:(NSInteger)index {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (!self.rememberLocation) return;
#pragma clang diagnostic pop
    UIScrollView *scrollView = [self pv_isKindOfScrollViewController:controller];
    if (scrollView) {
        CGPoint pos = scrollView.contentOffset;
        self.posRecords[@(index)] = [NSValue valueWithCGPoint:pos];
    }
}

- (UIScrollView *)pv_isKindOfScrollViewController:(UIViewController *)controller {
    UIScrollView *scrollView = nil;
    if ([controller.view isKindOfClass:[UIScrollView class]]) {
        // Controller的view是scrollView的子类(UITableViewController/UIViewController替换view为scrollView)
        scrollView = (UIScrollView *)controller.view;
    } else if (controller.view.subviews.count >= 1) {
        // Controller的view的subViews[0]存在且是scrollView的子类，并且frame等与view得frame(UICollectionViewController/UIViewController添加UIScrollView)
        UIView *view = controller.view.subviews[0];
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)view;
        }
    }
    return scrollView;
}

- (BOOL)pv_isInScreen:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat ScreenWidth = self.pageScrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.pageScrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) > contentOffsetX && x - contentOffsetX < ScreenWidth) {
        return YES;
    } else {
        return NO;
    }
}

- (void)pv_resetMenuView {
    if (!self.menuView) {
        [self pv_addMenuView];
    } else {
        if (self.menuView.contentScrollView != self.pageScrollView) {
            self.menuView.contentScrollView = self.pageScrollView;
        }
        [self.menuView reloadData];
        if (self.menuView.userInteractionEnabled == NO) {
            self.menuView.userInteractionEnabled = YES;
        }
        if (self.selectIndex != 0) {
            [self.menuView selectItemAtIndex:self.selectIndex];
        }
        [self.view bringSubviewToFront:self.menuView];
    }
}

- (void)pv_growCachePolicyAfterMemoryWarning {
    self.cachePolicy = OCFPageCachePolicyBalanced;
    [self performSelector:@selector(pv_growCachePolicyToHigh) withObject:nil afterDelay:2.0 inModes:@[NSRunLoopCommonModes]];
}

- (void)pv_growCachePolicyToHigh {
    self.cachePolicy = OCFPageCachePolicyHigh;
}

- (void)pv_adjustScrollViewFrame {
    // While rotate at last page, set scroll frame will call `-scrollViewDidScroll:` delegate
    // It's not my expectation, so I use `_shouldNotScroll` to lock it.
    // Wait for a better solution.
    _shouldNotScroll = YES;
    CGFloat oldContentOffsetX = self.pageScrollView.contentOffset.x;
    CGFloat contentWidth = self.pageScrollView.contentSize.width;
    self.pageScrollView.frame = _contentViewFrame;
    self.pageScrollView.contentSize = CGSizeMake(self.childControllersCount * _contentViewFrame.size.width, 0);
    CGFloat xContentOffset = contentWidth == 0 ? self.selectIndex * _contentViewFrame.size.width : oldContentOffsetX / contentWidth * self.childControllersCount * _contentViewFrame.size.width;
    [self.pageScrollView setContentOffset:CGPointMake(xContentOffset, 0)];
    _shouldNotScroll = NO;
}

- (void)pv_adjustDisplayingViewControllersFrame {
    [self.displayVC enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIViewController * _Nonnull vc, BOOL * _Nonnull stop) {
        NSInteger index = key.integerValue;
        CGRect frame = [self.childViewFrames[index] CGRectValue];
        vc.view.frame = frame;
    }];
}

- (void)pv_adjustMenuViewFrame {
    CGFloat oriWidth = self.menuView.frame.size.width;
    self.menuView.frame = _menuViewFrame;
    [self.menuView resetFrames];
    if (oriWidth != self.menuView.frame.size.width) {
        [self.menuView refreshContenOffset];
    }
}

- (CGFloat)pv_calculateItemWithAtIndex:(NSInteger)index {
    NSString *title = [self titleAtIndex:index];
    UIFont *titleFont = self.titleFontName ? [UIFont fontWithName:self.titleFontName size:self.titleSizeSelected] : [UIFont systemFontOfSize:self.titleSizeSelected];
    NSDictionary *attrs = @{NSFontAttributeName: titleFont};
    CGFloat itemWidth = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
    return ceil(itemWidth);
}

- (void)pv_delaySelectIndexIfNeeded {
    if (_markedSelectIndex != kOCFUndefinedInteger) {
        self.selectIndex = (NSInteger)_markedSelectIndex;
    }
}

#pragma mark dl
- (NSDictionary *)infoWithIndex:(NSInteger)index {
    NSString *title = [self titleAtIndex:index];
    return @{@"title": title ?: @"", @"index": @(index)};
}

- (void)willCachedController:(UIViewController *)vc atIndex:(NSInteger)index {
    if (self.childControllersCount && [self.delegate respondsToSelector:@selector(pageViewController:willCachedViewController:withInfo:)]) {
        NSDictionary *info = [self infoWithIndex:index];
        [self.delegate pageViewController:self willCachedViewController:vc withInfo:info];
    }
}

- (void)willEnterController:(UIViewController *)vc atIndex:(NSInteger)index {
    _selectIndex = index;
    if (self.childControllersCount && [self.delegate respondsToSelector:@selector(pageViewController:willEnterViewController:withInfo:)]) {
        NSDictionary *info = [self infoWithIndex:index];
        [self.delegate pageViewController:self willEnterViewController:vc withInfo:info];
    }
}

// 完全进入控制器 (即停止滑动后调用)
- (void)didEnterController:(UIViewController *)vc atIndex:(NSInteger)index {
    if (!self.childControllersCount) return;
    
    // Post FullyDisplayedNotification
    [self pv_postFullyDisplayedNotificationWithCurrentIndex:self.selectIndex];
    
    NSDictionary *info = [self infoWithIndex:index];
    if ([self.delegate respondsToSelector:@selector(pageViewController:didEnterViewController:withInfo:)]) {
        [self.delegate pageViewController:self didEnterViewController:vc withInfo:info];
    }
    
    // 当控制器创建时，调用延迟加载的代理方法
    if (_initializedIndex == index && [self.delegate respondsToSelector:@selector(pageViewController:lazyLoadViewController:withInfo:)]) {
        [self.delegate pageViewController:self lazyLoadViewController:vc withInfo:info];
        _initializedIndex = kOCFUndefinedInteger;
    }
    
    // 根据 preloadPolicy 预加载控制器
    if (self.preloadPolicy == OCFPagePreloadPolicyNever) return;
    int length = (int)self.preloadPolicy;
    int start = 0;
    int end = (int)self.childControllersCount - 1;
    if (index > length) {
        start = (int)index - length;
    }
    if (self.childControllersCount - 1 > length + index) {
        end = (int)index + length;
    }
    for (int i = start; i <= end; i++) {
        // 如果已存在，不需要预加载
        if (![self.memCache objectForKey:@(i)] && !self.displayVC[@(i)]) {
            [self pv_addViewControllerAtIndex:i];
            [self pv_postAddToSuperViewNotificationWithIndex:i];
        }
    }
    _selectIndex = index;
}

#pragma mark ds
- (NSInteger)childControllersCount {
    if (_controllerCount == kOCFUndefinedInteger) {
        if ([self.dataSource respondsToSelector:@selector(numbersOfChildControllersInPageViewController:)]) {
            _controllerCount = [self.dataSource numbersOfChildControllersInPageViewController:self];
        } else {
            _controllerCount = self.viewControllerClasses.count;
        }
    }
    return _controllerCount;
}

- (UIViewController * _Nonnull)initializeViewControllerAtIndex:(NSInteger)index {
    if ([self.dataSource respondsToSelector:@selector(pageViewController:viewControllerAtIndex:)]) {
        return [self.dataSource pageViewController:self viewControllerAtIndex:index];
    }
    return [[self.viewControllerClasses[index] alloc] init];
}

- (NSString * _Nonnull)titleAtIndex:(NSInteger)index {
    NSString *title = nil;
    if ([self.dataSource respondsToSelector:@selector(pageViewController:titleAtIndex:)]) {
        title = [self.dataSource pageViewController:self titleAtIndex:index];
    } else {
        title = self.titles[index];
    }
    return (title ?: @"");
}

#pragma mark - Public
- (void)forceLayoutSubviews {
    if (!self.childControllersCount) {
        return;
    }
    
    // 计算宽高及子控制器的视图frame
    [self pv_calculateSize];
    [self pv_adjustScrollViewFrame];
    [self pv_adjustMenuViewFrame];
    [self pv_adjustDisplayingViewControllersFrame];
}

- (void)reloadData {
    [super reloadData];
    
    [self pv_clearDatas];
    
    if (!self.childControllersCount) {
        return;
    }
    
    [self pv_resetScrollView];
    [self.memCache removeAllObjects];
    [self pv_resetMenuView];
    [self viewDidLayoutSubviews];
    [self didEnterController:self.currentViewController atIndex:self.selectIndex];
}

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index {
    [self.menuView updateTitle:title atIndex:index andWidth:NO];
}

- (void)updateAttributeTitle:(NSAttributedString * _Nonnull)title atIndex:(NSInteger)index {
    [self.menuView updateAttributeTitle:title atIndex:index andWidth:NO];
}

- (void)updateTitle:(NSString *)title andWidth:(CGFloat)width atIndex:(NSInteger)index {
    if (self.itemsWidths && index < self.itemsWidths.count) {
        NSMutableArray *mutableWidths = [NSMutableArray arrayWithArray:self.itemsWidths];
        mutableWidths[index] = @(width);
        self.itemsWidths = [mutableWidths copy];
    } else {
        NSMutableArray *mutableWidths = [NSMutableArray array];
        for (int i = 0; i < self.childControllersCount; i++) {
            CGFloat itemWidth = (i == index) ? width : self.menuItemWidth;
            [mutableWidths addObject:@(itemWidth)];
        }
        self.itemsWidths = [mutableWidths copy];
    }
    [self.menuView updateTitle:title atIndex:index andWidth:YES];
}

#pragma mark - Action
#pragma mark - Notification
- (void)willResignActive:(NSNotification *)notification {
    for (int i = 0; i < self.childControllersCount; i++) {
        id obj = [self.memCache objectForKey:@(i)];
        if (obj) {
            [self.backgroundCache setObject:obj forKey:@(i)];
        }
    }
}

- (void)willEnterForeground:(NSNotification *)notification {
    for (NSNumber *key in self.backgroundCache.allKeys) {
        if (![self.memCache objectForKey:key]) {
            [self.memCache setObject:self.backgroundCache[key] forKey:key];
        }
    }
    [self.backgroundCache removeAllObjects];
}

#pragma mark - Delegate
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    if (_shouldNotScroll || !_hasInited) {
        return;
    }
    
    [self pv_layoutChildViewControllers];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    _startDragging = YES;
    self.menuView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    self.menuView.userInteractionEnabled = YES;
    _selectIndex = (NSInteger)(scrollView.contentOffset.x / _contentViewFrame.size.width);
    self.currentViewController = self.displayVC[@(self.selectIndex)];
    [self didEnterController:self.currentViewController atIndex:self.selectIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    self.currentViewController = self.displayVC[@(self.selectIndex)];
    [self didEnterController:self.currentViewController atIndex:self.selectIndex];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    if (!decelerate) {
        self.menuView.userInteractionEnabled = YES;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (![scrollView isKindOfClass:OCFPageScrollView.class]) {
        return;
    }
    
    _targetX = targetContentOffset->x;
}

#pragma mark OCFPageMenuViewDataSource
- (NSInteger)numbersOfTitlesInMenuView:(OCFPageBaseMenuView *)menu {
    return self.childControllersCount;
}

- (NSString *)menuView:(OCFPageBaseMenuView *)menu titleAtIndex:(NSInteger)index {
    return [self titleAtIndex:index];
}

#pragma mark OCFPageMenuViewDelegate
- (void)menuView:(OCFPageBaseMenuView *)menu didSelectedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    if (!_hasInited) {
        return;
    }
    _selectIndex = index;
    _startDragging = NO;
    CGPoint targetP = CGPointMake(_contentViewFrame.size.width * index, 0);
    [self.pageScrollView setContentOffset:targetP animated:self.pageAnimatable];
    if (self.pageAnimatable) return;
    // 由于不触发 -scrollViewDidScroll: 手动处理控制器
    UIViewController *currentViewController = self.displayVC[@(currentIndex)];
    if (currentViewController) {
        [self pv_removeViewController:currentViewController atIndex:currentIndex];
    }
    [self pv_layoutChildViewControllers];
    self.currentViewController = self.displayVC[@(self.selectIndex)];
    
    [self didEnterController:self.currentViewController atIndex:index];
}

- (CGFloat)menuView:(OCFPageBaseMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    if (self.automaticallyCalculatesItemWidths) {
        return [self pv_calculateItemWithAtIndex:index];
    }
    
    if (self.itemsWidths.count == self.childControllersCount) {
        return [self.itemsWidths[index] floatValue];
    }
    return self.menuItemWidth;
}

- (CGFloat)menuView:(OCFPageBaseMenuView *)menu itemMarginAtIndex:(NSInteger)index {
    if (self.itemsMargins.count == self.childControllersCount + 1) {
        return [self.itemsMargins[index] floatValue];
    }
    return self.itemMargin;
}

- (CGFloat)menuView:(OCFPageBaseMenuView *)menu titleSizeForState:(OCFPageMenuCellState)state atIndex:(NSInteger)index {
    switch (state) {
        case OCFPageMenuCellStateSelected: return self.titleSizeSelected;
        case OCFPageMenuCellStateNormal: return self.titleSizeNormal;
    }
}

- (UIColor *)menuView:(OCFPageBaseMenuView *)menu titleColorForState:(OCFPageMenuCellState)state atIndex:(NSInteger)index {
    switch (state) {
        case OCFPageMenuCellStateSelected: return self.titleColorSelected;
        case OCFPageMenuCellStateNormal: return self.titleColorNormal;
    }
}

#pragma mark OCFPageViewControllerDataSource
- (OCFPageBaseMenuView *)menuViewForPageViewController:(OCFPageViewController *)pageViewController {
    NSAssert(0, @"[%@] MUST IMPLEMENT DATASOURCE METHOD `-menuViewForPageViewController:`", [self.dataSource class]);
    return nil;
}

- (CGRect)pageViewController:(OCFPageViewController *)pageViewController preferredFrameForMenuView:(OCFPageBaseMenuView *)menuView {
    NSAssert(0, @"[%@] MUST IMPLEMENT DATASOURCE METHOD `-pageViewController:preferredFrameForMenuView:`", [self.dataSource class]);
    return CGRectZero;
}

- (CGRect)pageViewController:(OCFPageViewController *)pageViewController preferredFrameForContentView:(OCFPageScrollView *)contentView {
    NSAssert(0, @"[%@] MUST IMPLEMENT DATASOURCE METHOD `-pageViewController:preferredFrameForContentView:`", [self.dataSource class]);
    return CGRectZero;
}

#pragma mark - Class

@end
