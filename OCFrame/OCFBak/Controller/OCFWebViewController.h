//
//  OCFWebViewController.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
#import "OCFWebViewReactor.h"

@interface OCFWebViewController : OCFViewController <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong, readonly) OCFWebViewReactor *reactor;
@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *bridge;

- (WKWebView *)createWebView;

@end

