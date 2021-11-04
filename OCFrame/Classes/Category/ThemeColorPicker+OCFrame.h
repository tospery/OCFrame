//
//  ThemeColorPicker+OCFrame.h
//  OCFrame
//
//  Created by liaoya on 2021/10/28.
//

#import <SwiftTheme/SwiftTheme-Swift.h>

#define OCFColorPicker(keypath)             ([ThemeColorPicker pickerWithKeyPath:(keypath)])

@interface ThemeColorPicker (OCFrame)
@property(class, nonatomic, readonly) ThemeColorPicker *white;
@property(class, nonatomic, readonly) ThemeColorPicker *black;
@property(class, nonatomic, readonly) ThemeColorPicker *background;
@property(class, nonatomic, readonly) ThemeColorPicker *foreground;
@property(class, nonatomic, readonly) ThemeColorPicker *bright;
@property(class, nonatomic, readonly) ThemeColorPicker *dim;
@property(class, nonatomic, readonly) ThemeColorPicker *primary;
@property(class, nonatomic, readonly) ThemeColorPicker *secondary;
@property(class, nonatomic, readonly) ThemeColorPicker *title;
@property(class, nonatomic, readonly) ThemeColorPicker *body;
@property(class, nonatomic, readonly) ThemeColorPicker *header;
@property(class, nonatomic, readonly) ThemeColorPicker *footer;
@property(class, nonatomic, readonly) ThemeColorPicker *border;
@property(class, nonatomic, readonly) ThemeColorPicker *separator;
@property(class, nonatomic, readonly) ThemeColorPicker *indicator;
@property(class, nonatomic, readonly) ThemeColorPicker *barTint;
@property(class, nonatomic, readonly) ThemeColorPicker *barText;

@end
