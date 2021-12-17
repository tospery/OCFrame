//
//  NSURL+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

#define OCFURLWithStr(x)                    ([NSURL ocf_urlWithString:(x)])
#define OCFURLWithBack(x)                   ([NSURL ocf_urlWithBack:(x)])
#define OCFURLWithHostpath(x)               ([NSURL ocf_urlWithHostpath:(x)])
#define OCFURLWithUniversal(x)              ([NSURL ocf_urlWithUniversal:(x)])

@interface NSURL (OCFrame)

+ (NSURL *)ocf_urlWithString:(NSString *)string;
+ (NSURL *)ocf_urlWithHostpath:(NSString *)hostpath;
+ (NSURL *)ocf_urlWithUniversal:(NSString *)universal;
+ (NSURL *)ocf_urlWithBack:(NSString *)path;

- (NSURL *)ocf_appendingQueryParameters:(NSDictionary<NSString *, id> *)parameters;

@end
