//
//  NSURL+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSURL+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>
#import <OCFrame/OCFCore.h>
#import "NSString+OCFExtensions.h"

@implementation NSURL (OCFExtensions)

+ (NSURL *)ocf_urlWithString:(NSString *)string {
    if (!string || ![string isKindOfClass:NSString.class] || !string.length) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        NSString *raw = string.qmui_trim;
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

- (NSURL *)ocf_appendingQueryParameters:(NSDictionary<NSString *, id> *)parameters {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray<NSURLQueryItem *> *items = [NSMutableArray<NSURLQueryItem *> arrayWithArray:urlComponents.queryItems];
    for (NSString *key in parameters.allKeys) {
        NSString *value = OCFStrWithObj(parameters[key]);
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
