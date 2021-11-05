//
//  NSURL+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

#define OCFURLWithStr(x)                    ([NSURL ocf_urlWithString:(x)])
#define OCFURLWithPath(x)                   ([NSURL ocf_urlWithPath:(x)])
#define OCFURLWithPattern(x)                ([NSURL ocf_urlWithPattern:(x)])

@interface NSURL (OCFrame)

+ (NSURL *)ocf_urlWithString:(NSString *)string;
+ (NSURL *)ocf_urlWithPath:(NSString *)path;
+ (NSURL *)ocf_urlWithPattern:(NSString *)pattern;

@end
