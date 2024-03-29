//
//  NSURL+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

#define OCFURLWithStr(x)                    ([NSURL ocf_urlWithString:(x)])

@interface NSURL (OCFExtensions)

+ (NSURL *)ocf_urlWithString:(NSString *)string;

@end

