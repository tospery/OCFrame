//
//  NSURL+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

#define OCFURLWithStr(x)                    ([NSURL ocf_urlWithString:(x)])
#define OCFURLWithUniversal(x)              ([NSURL ocf_urlWithUniversal:(x)])

@interface NSURL (OCFrame)

+ (NSURL *)ocf_urlWithString:(NSString *)string;
+ (NSURL *)ocf_urlWithUniversal:(NSString *)universal;

- (NSURL *)ocf_appendingQueryParameters:(NSDictionary<NSString *, id> *)parameters;

@end
