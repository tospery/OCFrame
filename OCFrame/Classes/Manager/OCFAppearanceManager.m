//
//  OCFAppearanceManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFAppearanceManager.h"
#import <SwiftTheme/SwiftTheme-Swift.h>
#import "ThemeColorPicker+OCFrame.h"

@interface OCFAppearanceManager ()

@end

@implementation OCFAppearanceManager

- (void)setup {
    // NavBar
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.theme_backgroundColor = ThemeColorPicker.barTint;
        appearance.shadowImage = [[UIImage alloc] init];
        appearance.shadowColor = nil;
        appearance.titleTextAttributes = @{
            NSForegroundColorAttributeName: UIColor.orangeColor,
            NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
        };
        UINavigationBar.appearance.standardAppearance = appearance;
        UINavigationBar.appearance.scrollEdgeAppearance = appearance;
    } else {
        UINavigationBar.appearance.translucent = NO;
        UINavigationBar.appearance.theme_barTintColor = ThemeColorPicker.barTint;
        UINavigationBar.appearance.titleTextAttributes = @{
            NSForegroundColorAttributeName: UIColor.orangeColor,
            NSFontAttributeName: [UIFont boldSystemFontOfSize:17]
        };
    }
    
    // TabBar
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.theme_backgroundColor = ThemeColorPicker.barTint;
        appearance.shadowImage = [[UIImage alloc] init];
        appearance.shadowColor = nil;
        UITabBar.appearance.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            UITabBar.appearance.scrollEdgeAppearance = appearance;
        }
    } else {
        UITabBar.appearance.translucent = NO;
        UITabBar.appearance.theme_barTintColor = ThemeColorPicker.barTint;
    }
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
