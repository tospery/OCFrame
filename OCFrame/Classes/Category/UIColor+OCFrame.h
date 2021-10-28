//
//  UIColor+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

#define OCFColorRGB(r, g, b)                (UIColorMake((r), (g), (b)))
#define OCFColorVal(value)                  ([UIColor ocf_colorWithHex:(value)])
#define OCFColorStr(string)                 ([UIColor qmui_colorWithHexString:(string)])

@interface UIColor (OCFrame)

@end

