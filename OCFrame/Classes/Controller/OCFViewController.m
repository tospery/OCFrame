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
#import "OCFrameManager.h"
#import "OCFLoginViewController.h"
#import "OCFViewController.h"
#import "NSDictionary+OCFrame.h"
#import "UIViewController+OCFrame.h"
#import "NSError+OCFrame.h"
#import "NSObject+OCFrame.h"
#import "UIColor+OCFrame.h"
#import "OCFScrollItem.h"
#import "UIImage+OCFrame.h"
#import "RACBehaviorSubject+OCFrame.h"

@interface OCFViewController ()
@property (nonatomic, assign) BOOL onceTokenForReload;
@property (nonatomic, assign, readwrite) CGFloat contentTop;
@property (nonatomic, assign, readwrite) CGFloat contentBottom;
@property (nonatomic, assign, readwrite) CGRect contentFrame;
@property (nonatomic, strong, readwrite) id<RACSubscriber> subscriber;
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
        id subscriber = OCFObjMember(reactor.parameters, OCFParameter.subscriber, nil);
        if (subscriber && [subscriber conformsToProtocol:@protocol(RACSubscriber)]) {
            self.subscriber = (id<RACSubscriber>)subscriber;
        }
    }
    return self;
}

- (void)dealloc {
    OCFLogDebug(@"%@已析构", self.ocf_className);
    [self.reactor unbinded];
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.view.backgroundColor = UIColor.ocf_background;
    
    if (!self.navigationItem.backBarButtonItem &&
        self.navigationController &&
        self.navigationController.childViewControllers.count > 1) {
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
    
    if (self.navigationController.childViewControllers.count > 1) {
        UIButton *backButton = [self.navigationBar addBackButtonToLeft];
        @weakify(self)
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
            @strongify(self)
            [self handleNavigate:kOCFBackPopone];
        }];
    } else {
        if (self.qmui_isPresented && self.navigationController.qmui_isPresented) {
            UIButton *closeButton = [self.navigationBar addCloseButtonToLeft];
            @weakify(self)
            [[closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
                @strongify(self)
                [self handleNavigate:kOCFBackDismiss];
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navigationBar]; // YJX_TODO 优化
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [STATUSBARSTYLE_SUBJECT.value integerValue];
}

#pragma mark - Property
#pragma mark - Method
#pragma mark bind
#pragma mark data
#pragma mark error
- (BOOL)filterError:(NSError *)error {
    return error.ocf_isCancelled;
}

- (void)handleError:(NSError *)error {
    self.reactor.error = error;
    [self.navigator toastMessage:OCFStrWithDft(error.localizedDescription, kStringErrorUnknown)];
}

#pragma mark navigate
- (BOOL)filterNavigate:(id)next {
    return NO;
}

- (void)handleNavigate:(id)next {
    RACTuple *tuple = [self convertNavigate:next];
    if (!tuple) {
        return;
    }
    NSURL *url = (NSURL *)tuple.first;
    if ([url.host isEqualToString:kOCFBackAuto]) {
        // back
        @weakify(self)
        OCFVoidBlock completion = ^(void) {
            @strongify(self)
            id result = tuple.second;
            if (result) {
                [self.subscriber sendNext:RACTuplePack(self.reactor.url, result)];
            }
            [self.subscriber sendCompleted];
        };
        NSString *poponePath = [kOCFBackPopone componentsSeparatedByString:@"/"].lastObject;
        NSString *popallPath = [kOCFBackPopall componentsSeparatedByString:@"/"].lastObject;
        NSString *dismissPath = [kOCFBackDismiss componentsSeparatedByString:@"/"].lastObject;
        NSString *fadeawayPath = [kOCFBackFadeaway componentsSeparatedByString:@"/"].lastObject;
        NSString *path = url.path;
        if (path.length == 0) {
            if (self.qmui_isPresented) {
                path = dismissPath;
            } else {
                path = poponePath;
            }
        }
        if ([path hasPrefix:@"/"]) {
            path = [path qmui_stringByRemoveCharacterAtIndex:0];
        }
        if ([path isEqualToString:poponePath]) {
            [self.navigationController qmui_popViewControllerAnimated:YES completion:completion];
        } else if ([path isEqualToString:popallPath]) {
            [self.navigationController qmui_popToRootViewControllerAnimated:YES completion:completion];
        }  else if ([path isEqualToString:dismissPath]) {
            [self dismissViewControllerAnimated:YES completion:completion];
        } else if ([path isEqualToString:fadeawayPath]) {
            OCFLogDebug(@"YJX_TODO kOCFPathFadeaway");
        }
    } else {
        // forward
        [[[self.navigator rac_routeURL:url withParameters:tuple.second] map:^id(id value) {
            return RACTuplePack(url, value);
        }] subscribe:self.reactor.result];
    }
}

- (RACTuple *)convertNavigate:(id)next {
    if (!next) {
        return nil;
    }
    if ([next isKindOfClass:RACTuple.class]) {
        RACTuple *tuple = (RACTuple *)next;
        if ([tuple.first isKindOfClass:NSURL.class]) {
            NSURL *url = (NSURL *)tuple.first;
            if ([url.host isEqualToString:kOCFBackAuto]) {
                return RACTuplePack(url, tuple.second);
            }
            if (!(!tuple.second || [tuple.second isKindOfClass:NSDictionary.class])) {
                return nil;
            }
            return RACTuplePack(url, tuple.second);
        } else if ([tuple.first isKindOfClass:NSString.class]) {
            NSString *string = (NSString *)tuple.first;
            NSURL *url = OCFURLWithUniversal(string);
            if (!url) {
                return nil;
            }
            NSArray *components = [string componentsSeparatedByString:@"/"];
            if ([components.firstObject isEqualToString:kOCFBackAuto]) {
                return RACTuplePack(url, tuple.second);
            }
            if (!(!tuple.second || [tuple.second isKindOfClass:NSDictionary.class])) {
                return nil;
            }
            return RACTuplePack(url, tuple.second);
        }
        return nil;
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


#pragma mark request
#pragma mark configure
#pragma mark convenient
- (UIStatusBarStyle)reversedStatusBarStyle {
    UIStatusBarStyle style = [STATUSBARSTYLE_SUBJECT.value integerValue];
    return (style == UIStatusBarStyleLightContent ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent);
}

#pragma mark - Delegate
#pragma mark - Class

#pragma mark - 备份

#pragma mark - Property
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
    BOOL translucent = NO;
    if (@available(iOS 13.0, *)) {
        translucent = tabBar.standardAppearance.backgroundEffect; // YJX_TODO 待优化
    } else {
        translucent = tabBar.isTranslucent;
    }
    if (tabBar && !tabBar.hidden && !translucent && !self.hidesBottomBarWhenPushed) {
        value = tabBar.qmui_height;
    }
    return value;
}

- (CGRect)contentFrame {
    return CGRectMake(0, self.contentTop, self.view.qmui_width, self.view.qmui_height - self.contentTop - self.contentBottom);
}

#pragma mark - Bind
- (void)bind:(OCFViewReactor *)reactor {
    // Action (View -> Reactor)
    [self.reactor.loadCommand.errors subscribe:self.reactor.errors];
    
    // State (Reactor -> View)
    RAC(self.navigationBar.titleLabel, text) = RACObserve(self.reactor, title);
    RAC(self.navigationItem, title) = RACObserve(self.reactor, title);
    @weakify(self)
    [self.reactor.loading.distinctUntilChanged subscribeNext:^(NSNumber *loading) {
        @strongify(self)
        self.reactor.isLoading = loading.boolValue;
        if (self.reactor.isLoading) {
            [self reloadData];
        }
    }];
    [[self.reactor.executing.distinctUntilChanged skip:1] subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            [self.navigator showToastActivity:OCFToastPositionCenter];
        } else {
            [self.navigator hideToastActivity];
        }
    }];
    [[self.reactor.errors filter:^BOOL(NSError *error) {
        @strongify(self)
        return ![self filterError:error];
    }] subscribeNext:^(NSError *error) {
        @strongify(self)
        [self handleError:error];
    }];
    [[self.reactor.navigate filter:^BOOL(id next) {
        @strongify(self)
        return ![self filterNavigate:next];
    }] subscribeNext:^(id next) {
        @strongify(self)
        [self handleNavigate:next];
    }];
//    [[RACSignal zip:@[
//        self.reactor.loading,
//        RACObserve(self.reactor, dataSource)
//    ]].deliverOnMainThread subscribeNext:^(RACTuple * _Nullable x) {
//
//    }];
    [[RACObserve(self.reactor, dataSource).distinctUntilChanged skip:1].deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
//    [[[RACObserve(self.reactor.user, isLogined) skip:1] ignore:@(NO)].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *isLogined) {
//        @strongify(self)
//        [self handleError];
//    }];
    [[RACObserve(self.reactor.user, isLogined).distinctUntilChanged skip:1].deliverOnMainThread subscribeNext:^(NSNumber *value) {
        @strongify(self)
        BOOL isLogined = value.boolValue;
        if (isLogined) {
            return;
        }
        if (!self.reactor.error) {
            return;
        }
        if (self.reactor.error.code != OCFErrorCodeLoginExpired) {
            return;
        }
        [self.reactor.user logout];
        if ([OCFUser canAutoOpenLoginPage]) {
            [self handleNavigate:kOCFHostLogin];
        }
    }];
}

#pragma mark - Load
- (void)beginLoad {
    self.reactor.requestMode = OCFRequestModeLoad;
    if (self.reactor.error || self.reactor.dataSource) {
        self.reactor.error = nil;
        self.reactor.dataSource = nil;
    }
}

- (void)triggerLoad {
    [self beginLoad];
    @weakify(self)
    [[self.reactor.loadCommand execute:nil] subscribeNext:^(id data) {
    } completed:^{
        @strongify(self)
        [self endLoad];
    }];
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
    [[self.reactor.loadCommand execute:nil].deliverOnMainThread subscribeNext:^(id data) {
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
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
        [viewController.reactor willBind];
        [viewController bind:viewController.reactor];
        [viewController.reactor didBind];
    }];
    return viewController;
}

@end
