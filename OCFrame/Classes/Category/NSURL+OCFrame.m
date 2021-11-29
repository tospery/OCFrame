//
//  NSURL+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSURL+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
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

+ (NSURL *)ocf_urlWithPath:(NSString *)path {
    if (!path || ![path isKindOfClass:NSString.class] || !path.length || [path isEqualToString:@"/"]) {
        return nil;
    }
    NSString *pathString = path;
    if ([pathString hasPrefix:@"/"]) {
        pathString = [pathString substringFromIndex:1];
    }
    NSString *urlString = OCFStrWithFmt(@"%@/%@", UIApplication.sharedApplication.ocf_baseWebUrlString, pathString);
    return [NSURL URLWithString:urlString];
}

+ (NSURL *)ocf_urlWithPattern:(NSString *)pattern {
    if (!pattern || ![pattern isKindOfClass:NSString.class] || !pattern.length || [pattern isEqualToString:@"/"]) {
        return nil;
    }
    NSString *pathString = pattern;
    if ([pathString hasPrefix:@"/"]) {
        pathString = [pathString substringFromIndex:1];
    }
    NSString *urlString = OCFStrWithFmt(@"%@://%@", UIApplication.sharedApplication.ocf_urlScheme, pathString);
    return [NSURL URLWithString:urlString];
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
