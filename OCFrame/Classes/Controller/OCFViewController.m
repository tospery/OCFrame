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
    
    if (self.qmui_isPresented && self.navigationController.qmui_isPresented) {
        UIButton *closeButton = [self.navigationBar addCloseButtonToLeft];
        @weakify(self)
        [[closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
            @strongify(self)
            [self handleNavigate:OCFURLWithBack(kOCFPathDismiss)];
        }];
    } else {
        UIButton *backButton = [self.navigationBar addBackButtonToLeft];
        @weakify(self)
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIControl *button) {
            @strongify(self)
            [self handleNavigate:OCFURLWithBack(kOCFPathPop)];
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.navigationBar]; // YJX_TODO 优化
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

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
    // Action (View -> Reactor)
    [self.reactor.loadCommand.errors subscribe:self.reactor.errors];
    
    // State (Reactor -> View)
    RAC(self.navigationBar.titleLabel, text) = RACObserve(self.reactor, title);
    RAC(self.navigationItem, title) = RACObserve(self.reactor, title);
    @weakify(self)
    [[self.reactor.executing skip:1] subscribeNext:^(NSNumber *executing) {
        @strongify(self)
        if (executing.boolValue) {
            [self.navigator showToastActivity:OCFToastPositionCenter];
        } else {
            [self.navigator hideToastActivity];
        }
    }];
    [[self.reactor.errors filter:^BOOL(NSError *error) {
        @strongify(self)
        self.reactor.error = error;
        return ![self filterError];
    }] subscribeNext:^(NSError *error) {
        @strongify(self)
        [self handleError];
    }];
    [[self.reactor.navigate filter:^BOOL(id next) {
        @strongify(self)
        return ![self filterNavigate:next];
    }] subscribeNext:^(id next) {
        @strongify(self)
        [self handleNavigate:next];
    }];
    [RACObserve(self.reactor, dataSource).distinctUntilChanged.deliverOnMainThread subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    [[[RACObserve(self.reactor.user, isLogined) skip:1] ignore:@(NO)].distinctUntilChanged.deliverOnMainThread subscribeNext:^(NSNumber *isLogined) {
        @strongify(self)
        [self handleError];
    }];
}

#pragma mark - Navigate
- (BOOL)filterNavigate:(id)next {
    return NO;
}

- (void)handleNavigate:(id)next {
    RACTuple *tuple = [self convertNavigate:next];
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
            if (self.reactor.result) {
                [self.subscriber sendNext:self.reactor.result];
            }
            [self.subscriber sendCompleted];
        };
        NSString *path = url.path;
        if (path.length == 0) {
            if (self.qmui_isPresented) {
                path = kOCFPathDismiss;
            } else {
                path = kOCFPathPop;
            }
        }
        if ([path hasPrefix:@"/"]) {
            path = [path qmui_stringByRemoveCharacterAtIndex:0];
        }
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
        } else if ([path isEqualToString:kOCFPathFadeaway]) {
            OCFLogDebug(@"YJX_TODO kOCFPathFadeaway");
        }
    } else {
        // forward
        [self.navigator routeURL:url withParameters:parameters];
    }
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

#pragma mark - Error
- (BOOL)filterError {
    return NO;
}

- (void)handleError {
    [self.navigator toastMessage:OCFStrWithDft(self.reactor.error.ocf_displayMessage, kStringErrorUnknown)];
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
