//
//  UIColor+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import <DKNightVersion/DKNightVersion.h>

#define OCFColorRGB(r, g, b)                (UIColorMake((r), (g), (b)))
#define OCFColorVal(value)                  ([UIColor ocf_colorWithHex:(value)])
#define OCFColorStr(string)                 ([UIColor qmui_colorWithHexString:(string)])
#define OCFColorKey(t)                      (DKColorPickerWithKey(t)(self.dk_manager.themeVersion))

//#define OCFColorRGB(r, g, b)                 (UIColorMake((r), (g), (b)))
//#define OCFColorKey(t)                       (DKColorPickerWithKey(t)(self.dk_manager.themeVersion))
//#pragma mark 黑白
//#define OCFColorClear                        (UIColorMakeWithRGBA(255, 255, 255, 0))
//#define OCFColorWhite                        (UIColorMake(255, 255, 255))
//#define OCFColorBlack                        (UIColorMake(0, 0, 0))

@interface UIColor (OCFrame)

@end

