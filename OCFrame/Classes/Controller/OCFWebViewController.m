//
//  OCFWebViewController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFWebViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import <Toast/UIView+Toast.h>
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFParameter.h"
#import "OCFWebViewReactor.h"
#import "OCFWebProgressView.h"
#import "NSString+OCFrame.h"
#import "NSURL+OCFrame.h"
#import "ThemeColorPicker+OCFrame.h"

#define kOCFWebEstimatedProgress         (@"estimatedProgress")

@interface OCFWebViewController ()
@property (nonatomic, strong) OCFWebProgressView *progressView;
@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong, readwrite) OCFWebViewReactor *reactor;

@end

@implementation OCFWebViewController
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithReactor:(OCFViewReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super initWithReactor:reactor navigator:navigator]) {
    }
    return self;
}

- (void)dealloc {
    _webView.navigationDelegate = nil;
    _webView.UIDelegate = nil;
    _webView = nil;
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [self createWebView];
    self.webView.theme_backgroundColor = ThemeColorPicker.background;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];

    @weakify(self)
    for (NSString *handler in self.reactor.ocHandlers) {
        if (![handler isKindOfClass:NSString.class]) {
            continue;
        }
        [self.bridge registerHandler:handler handler:^(id data, WVJBResponseCallback responseCallback) {
            @strongify(self)
            NSString *method = OCFStrWithFmt(@"%@:callback:", handler.ocf_camelFromUnderline);
            SEL selector = NSSelectorFromString(method);
            if ([self.reactor respondsToSelector:selector]) {
                ((id(*)(id, SEL, id, WVJBResponseCallback))[self.reactor methodForSelector:selector])(self.reactor, selector, data, responseCallback);
            }else {
                OCFLogWarn(kOCFLogTagNormal, @"Web找不到oc handler: %@", method);
                [self.navigator routeURL:OCFURLWithPattern(kOCFPatternToast) withParameters:@{
                    OCFParameter.message: OCFStrWithFmt(@"缺少%@方法", method)
                }];
            }
        }];
    }
    OCFLogDebug(kOCFLogTagNormal, @"webView frame = %@", NSStringFromCGRect(self.webView.frame));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - Property
- (OCFWebProgressView *)progressView {
    if (!_progressView) {
        OCFWebProgressView *progressView = [[OCFWebProgressView alloc] initWithFrame:CGRectMake(0, self.contentTop, self.view.qmui_width, 1.5f)];
        progressView.progressBarView.backgroundColor = self.reactor.progressColor;
        _progressView = progressView;
    }
    return _progressView;
}

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
    }
    return _bridge;
}

#pragma mark - Method
- (WKWebView *)createWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [[WKUserContentController alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.contentFrame configuration:configuration];
    return webView;
}

- (void)bind:(OCFBaseReactor *)reactor {
    [super bind:reactor];

    @weakify(self)
    [self.webView rac_observeKeyPath:kOCFWebEstimatedProgress options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        if ([value isKindOfClass:NSNumber.class]) {
            [self updateProgress:[(NSNumber *)value floatValue]];
        }
    }];
}

- (void)reloadData {
    [super reloadData];
}

- (void)triggerLoad {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.reactor.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [self.webView loadRequest:request];
}

- (void)updateProgress:(CGFloat)progress {
    [self.progressView setProgress:progress animated:YES];
    if (self.reactor.title.length == 0) {
        @weakify(self)
        [self.webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *title, NSError *error) {
            @strongify(self)
            self.reactor.title = title;
        }];
    }
}

#pragma mark - Delegate
#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    OCFLogDebug(kOCFLogTagNormal, @"decidePolicyForNavigationAction: %@", navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.progressView setProgress:0 animated:NO];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // [self didFinish:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // [self didFinish:error];
    OCFLogError(kOCFLogTagNormal, @"didFailNavigation: %@", error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // [self didFinish:error];
    OCFLogError(kOCFLogTagNormal, @"didFailProvisionalNavigation: %@", error);
}

#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Class

@end
