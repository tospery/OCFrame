//
//  UIView+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "OCFBorderLayer.h"

@interface UIView (OCFExtensions)
@property (nonatomic, assign) CGFloat ocf_borderWidth;
@property (nonatomic, assign) CGFloat ocf_cornerRadius;
@property (nonatomic, strong, readonly) OCFBorderLayer *ocf_borderLayer;

@end

