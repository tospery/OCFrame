//
//  OCFViewController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFViewController.h"
#import <QMUIKit/QMUIKit.h>
//#import <DKNightVersion/DKNightVersion.h>
#import <Toast/UIView+Toast.h>
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFString.h"
#import "OCFAppDependency.h"
#import "OCFParameter.h"
#import "OCFViewController.h"
#import "NSDictionary+OCFrame.h"
#import "UIViewController+OCFrame.h"
#import "NSError+OCFrame.h"

@interface OCFViewController ()
//@property (nonatomic, strong) UIButton *backButton;
//@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, assign, readwrite) CGFloat contentTop;
@property (nonatomic, assign, readwrite) CGFloat contentBottom;
@property (nonatomic, assign, readwrite) CGRect contentFrame;
@property (nonatomic, strong, readwrite) OCFNavigationBar *navigationBar;
@property (nonatomic, strong, readwrite) OCFNavigator *navigator;
@property (nonatomic, strong, readwrite) OCFViewReactor *reactor;

@end

@implementation OCFViewController

#pragma mark - Init
- (instancetype)initWithReactor:(OCFViewReactor *)reactor {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.reactor = reactor;
        @weakify(self)
        [[self rac_signalForSelector:@selector(bind:)] subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            if (self.reactor.shouldRequestRemoteData) {
                if (!self.reactor.dataSource) {
                    [self triggerLoad];
                }else {
                    [self triggerUpdate];
                }
            }
            // [self.reactor.loadCommand execute:nil];
            //[self.reactor.load sendNext:nil];
        }];
    }
    return self;
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationController.navigationBar.hidden = YES;
    if (!self.reactor.hidesNavigationBar) {
        [self addNavigationBar];
        if (self.reactor.hidesNavBottomLine) {
            self.navigationBar.qmui_borderLayer.hidden = YES;
        }
    }
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backButton = [self.navigationBar addBackButtonToLeft];
        @weakify(self)
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
            @strongify(self)
            [self.navigator popReactorAnimated:YES completion:nil];
        }];
    } else {
        if (self.presentingViewController) {
            UIButton *closeButton = [self.navigationBar addCloseButtonToLeft];
            @weakify(self)
            [[closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
                @strongify(self)
                [self.navigator dismissReactorAnimated:YES completion:nil];
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // [self.view bringSubviewToFront:self.navigationBar];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // [self.view bringSubviewToFront:self.navigationBar];
    // [self layoutEmptyView];
}

#pragma mark - Property
- (OCFNavigator *)navigator {
    if (!_navigator) {
        _navigator = OCFAppDependency.sharedInstance.navigator;
    }
    return _navigator;
}


- (OCFNavigationBar *)navigationBar {
    if (!_navigationBar) {
        OCFNavigationBar *navigationBar = [[OCFNavigationBar alloc] init];
        navigationBar.layer.zPosition = FLT_MAX;
        [navigationBar sizeToFit];
        _navigationBar = navigationBar;
    }
    return _navigationBar;
}

- (CGFloat)contentTop {
    CGFloat value = 0;
    UINavigationBar *navBar = self.navigationController.navigationBar;
    if ((navBar && !navBar.hidden) || !self.reactor.hidesNavigationBar) {
        value += OCFNavContentTopConstant;
    }
//    OCFPageMenuView *menuView = self.ocf_pageViewController.menuView;
//    if (menuView && !menuView.hidden) {
//        value += menuView.qmui_height;
//    }
    return value;
}

- (CGFloat)contentBottom {
    CGFloat value = OCFSafeBottom;
    UITabBar *tabBar = self.tabBarController.tabBar; // self.ocf_tabBarViewController.innerTabBarController.tabBar;
    if (tabBar && !tabBar.hidden && !self.hidesBottomBarWhenPushed) {
        value += tabBar.qmui_height;
    }
    return value;
}

- (CGRect)contentFrame {
    return CGRectMake(0, self.contentTop, self.view.qmui_width, self.view.qmui_height - self.contentTop - self.contentBottom);
}

#pragma mark - Bind
- (void)bind:(OCFViewReactor *)reactor {
    @weakify(self)
    // Action (View -> Reactor)
    [[self.reactor.requestRemoteCommand.errors filter:self.errorFilter] subscribe:self.reactor.errors];
    
    // State (Reactor -> View)
    RAC(self.navigationBar.titleLabel, text) = RACObserve(self.reactor, title);
    [RACObserve(self.reactor, dataSource).deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    [[[RACObserve(self.reactor.user, isLogined) skip:1] ignore:@(NO)].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *isLogined) {
        @strongify(self)
        [self handleError];
    }];
    [[RACObserve(self.reactor, hidesNavigationBar) skip:1].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *hide) {
        @strongify(self)
        hide.boolValue ? [self removeNavigationBar] : [self addNavigationBar];
    }];
    [[RACObserve(self.reactor, hidesNavBottomLine) skip:1].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *hide) {
        @strongify(self)
        self.navigationBar.qmui_borderLayer.hidden = hide.boolValue;
    }];
    [[self.reactor.executing skip:1] subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            self.view.userInteractionEnabled = NO;
            [self.view makeToastActivity:CSToastPositionCenter];
        } else {
            self.view.userInteractionEnabled = YES;
            [self.view hideToastActivity];
        }
    }];
//    [self.reactor.load subscribeNext:^(id x) {
//        @strongify(self)
//        if (self.reactor.shouldRequestRemoteData) {
//            if (!self.reactor.dataSource) {
//                [self triggerLoad];
//            }else {
//                [self triggerUpdate];
//            }
//        }
//    }];
    [self.reactor.errors subscribeNext:^(NSError *error) {
        @strongify(self)
        [self.navigator routeURL:OCFURLWithPattern(kOCFPatternToast) withParameters:@{
            OCFParameter.message: OCFStrWithDft(error.ocf_displayMessage, kStringErrorUnknown)
        }];
    }];
    [self.reactor.navigate subscribeNext:^(id input) {
        @strongify(self)
        if ([input isKindOfClass:RACTuple.class] && [(RACTuple *)input count] == 2) {
            RACTuple *tuple = (RACTuple *)input;
            id first = tuple.first;
            id second = tuple.second;
            // 1. forward
            if ([first isKindOfClass:NSURL.class] &&
                (!second || [second isKindOfClass:NSDictionary.class])) {
                [self.navigator routeURL:first withParameters:second];
            }
            // 2. back
            else if ([first isKindOfClass:NSNumber.class]) {
                OCFViewControllerBackType type = [(NSNumber *)first integerValue];
                OCFVoidBlock completion = ^(void) {
                    @strongify(self)
                    [self.reactor.resultCommand execute:second];
                };
                if (OCFViewControllerBackTypePopOne == type) {
                    [self.navigator popReactorAnimated:YES completion:completion];
                } else if (OCFViewControllerBackTypePopAll == type) {
                    [self.navigator popToRootReactorAnimated:YES completion:completion];
                } else if (OCFViewControllerBackTypeDismiss == type) {
                    [self.navigator dismissReactorAnimated:YES completion:completion];
                } else if (OCFViewControllerBackTypeClose == type) {
                    [self.navigator closeReactorWithAnimationType:OCFViewControllerAnimationTypeFromString(self.reactor.animation) completion:completion];
                }
            }
        }
    }];
}

- (BOOL (^)(NSError *error))errorFilter {
    @weakify(self)
    return ^(NSError *error) {
        @strongify(self)
        self.reactor.error = error;
        BOOL handled = ![self handleError];
        return handled;
    };
}

- (BOOL)handleError {
    return NO;
}

#pragma mark - Load
- (void)beginLoad {
    self.reactor.requestMode = OCFRequestModeLoad;
    if (self.reactor.error || self.reactor.dataSource) {
        self.reactor.error = nil;
        if (self.reactor.shouldFetchLocalData) {
            self.reactor.dataSource = [self.reactor data2Source:[self.reactor fetchLocalData]];
        } else {
            self.reactor.dataSource = nil;
        }
    }
}

- (void)triggerLoad {
    
}

- (void)endLoad {
    self.reactor.requestMode = OCFRequestModeNone;
}

#pragma mark - Update
- (void)beginUpdate {
    self.reactor.requestMode = OCFRequestModeUpdate;
    self.view.userInteractionEnabled = NO;
    [self.view makeToastActivity:CSToastPositionCenter];
}

- (void)triggerUpdate {
    [self beginUpdate];
    @weakify(self)
    [[self.reactor.requestRemoteCommand execute:nil].deliverOnMainThread subscribeNext:^(id data) {
    } completed:^{
        @strongify(self)
        [self endUpdate];
    }];
}

- (void)endUpdate {
    self.reactor.requestMode = OCFRequestModeNone;
    self.view.userInteractionEnabled = YES;
    [self.view hideToastActivity];
}

#pragma mark - Reload
- (void)reloadData {
    
}

#pragma mark - Navigation
- (void)addNavigationBar {
    if (!self.navigationBar.superview) {
        [self.view addSubview:self.navigationBar];
    }
}

- (void)removeNavigationBar {
    if (self.navigationBar.superview) {
        [self.navigationBar removeFromSuperview];
    }
}

#pragma mark - Delegate
#pragma mark UINavigationControllerBackButtonHandlerProtocol
- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return YES;
}

#pragma mark - Class
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController bind:viewController.reactor];
    }];
    return viewController;
}

@end
