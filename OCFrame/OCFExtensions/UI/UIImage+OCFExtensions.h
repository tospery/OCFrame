//
//  UIImage+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>
#import <OCFrame/OCFCore.h>

#define OCFImageAsset(x)        ([UIImage ocf_imageInAsset:(x)])
#define OCFImageFrame(x)        ([UIImage ocf_imageInFrame:OCFStrWithFmt(@"OCFrame/%@", (x))])
#define OCFImageColor(x)        ([UIImage qmui_imageWithColor:(x)])

@interface UIImage (OCFExtensions)
@property (class, strong, readonly) UIImage *ocf_back;
@property (class, strong, readonly) UIImage *ocf_close;
@property (class, strong, readonly) UIImage *ocf_indicator;
@property (class, strong, readonly) UIImage *ocf_loading;
@property (class, strong, readonly) UIImage *ocf_waiting;
@property (class, strong, readonly) UIImage *ocf_network;
@property (class, strong, readonly) UIImage *ocf_server;

+ (UIImage *)ocf_imageWithURL:(NSString *)urlString;
+ (UIImage *)ocf_imageInAsset:(NSString *)name;
+ (UIImage *)ocf_imageInFrame:(NSString *)path;
+ (UIImage *)ocf_imageInResource:(NSString *)name;
+ (UIImage *)ocf_imageInDocuments:(NSString *)name;

@end

