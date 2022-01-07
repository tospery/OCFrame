//
//  UIFont+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

#define OCFFont(x)                           ([UIFont systemFontOfSize:(x)])
#define OCFFontBold(x)                       ([UIFont boldSystemFontOfSize:(x)])
#define OCFFontLight(x)                      ([UIFont qmui_lightSystemFontOfSize:(x)])

@interface UIFont (OCFExtensions)

@end
