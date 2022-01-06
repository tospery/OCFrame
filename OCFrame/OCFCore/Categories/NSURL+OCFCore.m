//
//  NSURL+OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSURL+OCFCore.h"
#import "OCFDefines.h"
#import "NSString+OCFCore.h"

@implementation NSURL (OCFCore)

+ (NSURL *)ocf_urlWithString:(NSString *)string {
    if (!string || ![string isKindOfClass:NSString.class] || !string.length) {
        return nil;
    }
    NSURL *url = [NSURL URLWithString:string];
    if (url == nil) {
        NSString *raw = string.ocf_trim;
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
        NSString *value = OCFStrWithObj(parameters[key]); // YJX_TODO id -> json字符串
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
