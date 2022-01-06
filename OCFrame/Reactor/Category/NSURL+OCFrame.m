//
//  NSURL+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSURL+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import "OCFConstant.h"
#import "OCFrameManager.h"
#import "NSString+OCFrame.h"
#import "UIApplication+OCFrame.h"

@implementation NSURL (OCFrame)

+ (NSURL *)ocf_urlWithString:(NSString *)string {
    if (!string || ![string isKindOfClass:NSString.class] || !string.length) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        NSString *raw = [string qmui_trim];
        url = [NSURL URLWithString:raw];
        if (url == nil) {
            url = [NSURL URLWithString:raw.ocf_urlDecoded];
        }
        if (url == nil) {
            url = [NSURL URLWithString:raw.ocf_urlDecoded];
        }
    }
    return url;
}

+ (NSURL *)ocf_urlWithUniversal:(NSString *)universal {
    NSURL *url = [self ocf_urlWithString:universal];
    if (!(!url || url.scheme.length == 0 || url.host.length == 0)) {
        return url;
    }
    NSString *hostpath = universal;
    if ([hostpath hasPrefix:@"/"]) {
        hostpath = [hostpath substringFromIndex:1];
    }
    NSString *urlString = OCFStrWithFmt(@"%@://%@", UIApplication.sharedApplication.ocf_urlScheme, hostpath);
    return [NSURL ocf_urlWithString:urlString];
}

- (NSURL *)ocf_appendingQueryParameters:(NSDictionary<NSString *, id> *)parameters {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray<NSURLQueryItem *> *items = [NSMutableArray<NSURLQueryItem *> arrayWithArray:urlComponents.queryItems];
    for (NSString *key in parameters.allKeys) {
        NSString *value = [NSString ocf_stringWithObject:parameters[key]];
        if (!value) {
            continue;
        }
        NSURLQueryItem *query = [[NSURLQueryItem alloc] initWithName:key value:value];
        [items addObject:query];
    }
    urlComponents.queryItems = items;
    return urlComponents.URL;
}

@end