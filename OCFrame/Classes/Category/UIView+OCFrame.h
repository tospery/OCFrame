//
//  UIView+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFBorderLayer.h"

@interface UIView (OCFrame)
@property (nonatomic, assign) CGFloat ocf_borderWidth;
@property (nonatomic, assign) CGFloat ocf_cornerRadius;
@property (nonatomic, strong, readonly) OCFBorderLayer *ocf_borderLayer;
//@property (nonatomic, strong) ThemeColorPicker *theme_borderColor; // YJX_TODO

- (BOOL)ocf_toastWithParameters:(NSDictionary *)parameters completion:(void(^)(BOOL didTap))completion;

@end

