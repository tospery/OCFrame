//
//  OCFViewController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFViewController.h"
#import <QMUIKit/QMUIKit.h>
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
#import "NSObject+OCFrame.h"
#import "UIColor+OCFrame.h"
#import "OCFScrollItem.h"
#import "UIImage+OCFrame.h"

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
- (instancetype)initWithReactor:(OCFViewReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super init]) {
        self.reactor = reactor;
        self.navigator = navigator;
        self.hidesBottomBarWhenPushed = YES;
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

- (void)dealloc {
    OCFLogDebug(@"%@已析构", self.ocf_className);
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = UIColor.ocf_background;
    
    if (!self.navigationItem.backBarButtonItem) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:UIImage.ocf_back style:UIBarButtonItemStylePlain target:nil action:NULL];
        item.tintColor = UIColor.ocf_barText;
        @weakify(self)
        item.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal return:input];
        }];
        self.navigationItem.leftBarButtonItem = item;
    }
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.navigationBar];
    self.navigationBar.hidden = self.reactor.hidesNavigationBar;
    self.navigationBar.qmui_borderLayer.hidden = self.reactor.hidesNavBottomLine;
    
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
//- (OCFNavigator *)navigator {
//    if (!_navigator) {
//        _navigator = OCFAppDependency.sharedInstance.navigator;
//    }
//    return _navigator;
//}


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
    if (!self.reactor.hidesNavigationBar && !self.reactor.transparetNavBar) {
        value = NavigationContentTopConstant;
    }
    return value;
}

- (CGFloat)contentBottom {
    CGFloat value = 0;
    UITabBar *tabBar = self.tabBarController.tabBar;
    if (tabBar && !tabBar.hidden && !tabBar.isTranslucent && !self.hidesBottomBarWhenPushed) {
        value = tabBar.qmui_height;
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
    RAC(self.navigationItem, title) = RACObserve(self.reactor, title);
    [RACObserve(self.reactor, dataSource).deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    [[[RACObserve(self.reactor.user, isLogined) skip:1] ignore:@(NO)].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *isLogined) {
        @strongify(self)
        [self handleError];
    }];
//    [[RACObserve(self.reactor, hidesNavigationBar) skip:1].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *hide) {
//        @strongify(self)
//        hide.boolValue ? [self removeNavigationBar] : [self addNavigationBar];
//    }];
//    [[RACObserve(self.reactor, hidesNavBottomLine) skip:1].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *hide) {
//        @strongify(self)
//        self.navigationBar.qmui_borderLayer.hidden = hide.boolValue;
//    }];
    [[self.reactor.executing skip:1] subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            [self.navigator showToastActivity:OCFToastPositionCenter];
        } else {
            [self.navigator hideToastActivity];
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
        [self.navigator routeURL:OCFURLWithHostpath(kOCFHostToast) withParameters:@{
            OCFParameter.message: OCFStrWithDft(error.ocf_displayMessage, kStringErrorUnknown)
        }];
    }];
     [[self.reactor.navigate filter:^BOOL(id value) {
         @strongify(self)
         return [self filterNavigate:value];
     }] subscribeNext:^(id input) {
         @strongify(self)
         RACTuple *tuple = [self convertNavigate:input];
         if (!tuple) {
             return;
         }
         NSURL *url = (NSURL *)tuple.first;
         NSDictionary *parameters = (NSDictionary *)tuple.second;
         if ([url.host isEqualToString:kOCFHostBack]) {
             // back
             @weakify(self)
             OCFVoidBlock completion = ^(void) {
                 @strongify(self)
                 // 应该用self.result，并且也该onComplition
                 // [self.reactor.resultCommand execute:second];
                 [self.reactor.resultCommand execute:nil];
             };
             NSString *path = url.path;
             if ([path isEqualToString:kOCFPathPop]) {
                 NSNumber *all = OCFNumMember(url.qmui_queryItems, OCFParameter.all, nil);
                 if (!all) {
                     all = OCFNumMember(parameters, OCFParameter.all, nil);
                 }
                 if (all.boolValue) {
                     [self.navigationController qmui_popToRootViewControllerAnimated:YES completion:completion];
                 } else {
                     [self.navigationController qmui_popViewControllerAnimated:YES completion:completion];
                 }
             } else if ([path isEqualToString:kOCFPathDismiss]) {
                 [self dismissViewControllerAnimated:YES completion:completion];
             }
         } else {
             // forward
             [self.navigator routeURL:url withParameters:parameters];
         }
     }];
//    [self.reactor.navigate subscribeNext:^(id input) {
//        @strongify(self)
//        if ([input isKindOfClass:RACTuple.class] && [(RACTuple *)input count] == 2) {
//            RACTuple *tuple = (RACTuple *)input;
//            id first = tuple.first;
//            id second = tuple.second;
//            if ([first isKindOfClass:NSNumber.class]) {
//                // back
//                OCFViewControllerBackType type = [(NSNumber *)first integerValue];
//                @weakify(self)
//                OCFVoidBlock completion = ^(void) {
//                    @strongify(self)
//                    [self.reactor.resultCommand execute:second];
//                };
//                if (OCFViewControllerBackTypePopOne == type) {
//                    [self.navigator popReactorAnimated:YES completion:completion];
//                } else if (OCFViewControllerBackTypePopAll == type) {
//                    [self.navigator popToRootReactorAnimated:YES completion:completion];
//                } else if (OCFViewControllerBackTypeDismiss == type) {
//                    [self.navigator dismissReactorAnimated:YES completion:completion];
//                } else if (OCFViewControllerBackTypeClose == type) {
//                    [self.navigator fadeawayReactorWithAnimationType:OCFViewControllerAnimationTypeFromString(self.reactor.animation) completion:completion];
//                }
//            } else {
//                // forward
//                NSURL *url = nil;
//                if ([first isKindOfClass:NSURL.class]) {
//                    url = (NSURL *)first;
//                } else if ([first isKindOfClass:NSString.class]) {
//                    url = OCFURLWithStr((NSString *)first);
//                }
//                if (!url) {
//                    return;
//                }
//                NSDictionary *parameters = nil;
//                if ([second isKindOfClass:NSDictionary.class]) {
//                    parameters = (NSDictionary *)second;
//                }
//                [self.navigator routeURL:url withParameters:parameters];
//            }
//        }
//    }];
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

- (BOOL)filterNavigate:(id)next {
    RACTuple *tuple = [self convertNavigate:next];
    if (!tuple) {
        [self handleNavigate:next];
        return NO;
    }
    return YES;
}

- (void)handleNavigate:(id)next {
    
}

- (RACTuple *)convertNavigate:(id)next {
    if (!next) {
        return nil;
    }
    if ([next isKindOfClass:RACTuple.class]) {
        RACTuple *tuple = (RACTuple *)next;
        if (!(tuple.count == 2 &&
            [tuple.first isKindOfClass:NSURL.class] &&
            (!tuple.second || [tuple.second isKindOfClass:NSDictionary.class]))) {
            return nil;
        }
        return tuple;
    } else if ([next isKindOfClass:NSURL.class]) {
        return RACTuplePack(next, nil);
    } else if ([next isKindOfClass:NSString.class]) {
        NSString *string = (NSString *)next;
        NSURL *url = OCFURLWithUniversal(string);
        if (!url) {
            return nil;
        }
        return RACTuplePack(url, nil);
    }
    return nil;
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
    [self.navigator showToastActivity:OCFToastPositionCenter];
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
    [self.navigator hideToastActivity];
}

#pragma mark - Reload
- (void)reloadData {
    
}

#pragma mark - Navigation
//- (void)addNavigationBar {
//    if (!self.navigationBar.superview) {
//        [self.view addSubview:self.navigationBar];
//    }
//}
//
//- (void)removeNavigationBar {
//    if (self.navigationBar.superview) {
//        [self.navigationBar removeFromSuperview];
//    }
//}

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
