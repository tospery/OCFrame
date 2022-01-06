//
//  NSURL+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

#define OCFURLWithUniversal(x)              ([NSURL ocf_urlWithUniversal:(x)])

@interface NSURL (OCFrame)

+ (NSURL *)ocf_urlWithUniversal:(NSString *)universal;

@end
