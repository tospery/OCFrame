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

@end
