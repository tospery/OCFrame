//
//  NSURL+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSURL+OCFrame.h"
#import "OCFrameManager.h"
#import "NSString+OCFrame.h"

@implementation NSURL (OCFrame)

+ (NSURL *)ocf_urlWithPath:(NSString *)path {
    if (!path || ![path isKindOfClass:NSString.class] || !path.length || [path isEqualToString:@"/"]) {
        return nil;
    }
    NSString *pathString = path;
    if ([pathString hasPrefix:@"/"]) {
        pathString = [pathString substringFromIndex:1];
    }
    NSString *urlString = OCFStrWithFmt(@"%@/%@", OCFrameManager.sharedInstance.baseURLString, pathString);
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
    NSString *urlString = OCFStrWithFmt(@"%@://%@", OCFrameManager.sharedInstance.appScheme, pathString);
    return [NSURL URLWithString:urlString];
}

@end
