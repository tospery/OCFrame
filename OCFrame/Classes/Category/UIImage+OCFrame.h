//
//  UIImage+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

#define OCFImageFrame(x)        ([UIImage ocf_imageInFrame:OCFStrWithFmt(@"OCFrame/%@", (x))])
#define OCFImageColor(x)        ([UIImage qmui_imageWithColor:(x)])

@interface UIImage (OCFrame)
//@property (nonatomic, copy, setter = dk_setTintColorPicker:) DKColorPicker dk_tintColorPicker;
@property (class, strong, readonly) UIImage *ocf_back;
@property (class, strong, readonly) UIImage *ocf_close;
@property (class, strong, readonly) UIImage *ocf_indicator;
@property (class, strong, readonly) UIImage *ocf_loading;
@property (class, strong, readonly) UIImage *ocf_waiting;
@property (class, strong, readonly) UIImage *ocf_network;
@property (class, strong, readonly) UIImage *ocf_server;

+ (UIImage *)ocf_imageWithURL:(NSString *)urlString;
+ (UIImage *)ocf_imageInAsset:(NSString *)name;
+ (UIImage *)ocf_imageInFrame:(NSString *)name;
+ (UIImage *)ocf_imageInResource:(NSString *)name;
+ (UIImage *)ocf_imageInDocuments:(NSString *)name;

@end

