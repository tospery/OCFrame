//
//  UIFont+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "UIFont+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import "OCFrameManager.h"

@implementation UIFont (OCFrame)

+ (UIFont *)ocf_fontWithNormal:(CGFloat)size {
    return [UIFont systemFontOfSize:(size + OCFrameManager.sharedInstance.fontScale)];
}

+ (UIFont *)ocf_fontWithBold:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:(size + OCFrameManager.sharedInstance.fontScale)];
}

+ (UIFont *)ocf_fontWithLight:(CGFloat)size {
    return [UIFont qmui_lightSystemFontOfSize:(size + OCFrameManager.sharedInstance.fontScale)];
}

@end
