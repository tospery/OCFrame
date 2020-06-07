//
//  UIFont+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

#define OCFFont(x)                           ([UIFont ocf_fontWithNormal:(x)])
#define OCFFontBold(x)                       ([UIFont ocf_fontWithBold:(x)])
#define OCFFontLight(x)                      ([UIFont ocf_fontWithLight:(x)])

@interface UIFont (OCFrame)

+ (UIFont *)ocf_fontWithNormal:(CGFloat)size;
+ (UIFont *)ocf_fontWithBold:(CGFloat)size;
+ (UIFont *)ocf_fontWithLight:(CGFloat)size;

@end

