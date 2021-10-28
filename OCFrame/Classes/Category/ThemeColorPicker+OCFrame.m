//
//  ThemeColorPicker+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/10/28.
//

#import "ThemeColorPicker+OCFrame.h"

@implementation ThemeColorPicker (OCFrame)

+ (ThemeColorPicker *)background { return OCFColorPicker(@"backgroundColor"); }
+ (ThemeColorPicker *)foreground { return OCFColorPicker(@"foregroundColor"); }
+ (ThemeColorPicker *)light { return OCFColorPicker(@"lightColor"); }
+ (ThemeColorPicker *)dark { return OCFColorPicker(@"darkColor"); }
+ (ThemeColorPicker *)primary { return OCFColorPicker(@"primaryColor"); }
+ (ThemeColorPicker *)secondary { return OCFColorPicker(@"secondaryColor"); }
+ (ThemeColorPicker *)title { return OCFColorPicker(@"titleColor"); }
+ (ThemeColorPicker *)body { return OCFColorPicker(@"bodyColor"); }
+ (ThemeColorPicker *)header { return OCFColorPicker(@"headerColor"); }
+ (ThemeColorPicker *)footer { return OCFColorPicker(@"footerColor"); }
+ (ThemeColorPicker *)border { return OCFColorPicker(@"borderColor"); }
+ (ThemeColorPicker *)separator { return OCFColorPicker(@"separatorColor"); }
+ (ThemeColorPicker *)barTint { return OCFColorPicker(@"barTintColor"); }
+ (ThemeColorPicker *)barText { return OCFColorPicker(@"barTextColor"); }

@end
