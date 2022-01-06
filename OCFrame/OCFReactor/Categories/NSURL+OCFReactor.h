//
//  NSURL+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

#define OCFURLWithStr(x)                    ([NSURL ocf_urlWithString:(x)])

@interface NSURL (OCFReactor)

+ (NSURL *)ocf_urlWithString:(NSString *)string;

@end

