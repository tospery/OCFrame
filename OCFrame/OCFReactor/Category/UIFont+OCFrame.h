//
//  UIFont+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

#define OCFFont(x)                           ([UIFont systemFontOfSize:(x)])
#define OCFFontBold(x)                       ([UIFont boldSystemFontOfSize:(x)])
#define OCFFontLight(x)                      ([UIFont qmui_lightSystemFontOfSize:(x)])

@interface UIFont (OCFrame)

//+ (UIFont *)ocf_fontWithNormal:(CGFloat)size;
//+ (UIFont *)ocf_fontWithBold:(CGFloat)size;
//+ (UIFont *)ocf_fontWithLight:(CGFloat)size;

@end

