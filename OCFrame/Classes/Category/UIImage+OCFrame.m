//
//  UIImage+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "UIImage+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "NSString+OCFrame.h"
#import "NSBundle+OCFrame.h"

@interface UIImage ()
// @property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UIImage (OCFrame)

//- (DKColorPicker)dk_tintColorPicker {
//    return objc_getAssociatedObject(self, @selector(dk_tintColorPicker));
//}
//
//- (void)dk_setTintColorPicker:(DKColorPicker)picker {
//    objc_setAssociatedObject(self, @selector(dk_tintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self qmui_imageWithTintColor:picker(self.dk_manager.themeVersion)];
//    [self.pickers setValue:[picker copy] forKey:@"setTintColor"];
//}

+ (UIImage *)ocf_back {
    UIImage *image = OCFImageAsset(@"ic_back");
    return image ? image : OCFImageFrame(@"ic_back");
}

+ (UIImage *)ocf_close {
    UIImage *image = OCFImageAsset(@"ic_close");
    return image ? image : OCFImageFrame(@"ic_close");
}

+ (UIImage *)ocf_indicator {
    UIImage *image = OCFImageAsset(@"ic_indicator");
    return image ? image : OCFImageFrame(@"ic_indicator");
}

+ (UIImage *)ocf_loading {
    UIImage *image = OCFImageAsset(@"ic_loading");
    return image ? image : OCFImageFrame(@"ic_loading");
}

+ (UIImage *)ocf_waiting {
    UIImage *image = OCFImageAsset(@"ic_waiting");
    return image ? image : OCFImageFrame(@"ic_waiting");
}

+ (UIImage *)ocf_network {
    UIImage *image = OCFImageAsset(@"ic_errorNetwork");
    return image ? image : OCFImageFrame(@"ic_errorNetwork");
}

+ (UIImage *)ocf_server {
    UIImage *image = OCFImageAsset(@"ic_errorServer");
    return image ? image : OCFImageFrame(@"ic_errorServer");
}

+ (UIImage *)ocf_imageWithURL:(NSString *)urlString {
    NSString *asset = OCFStrWithFmt(@"%@://", kOCFSchemeAsset);
    if ([urlString hasPrefix:asset]) {
        return [self ocf_imageInAsset:[urlString substringFromIndex:asset.length]];
    }
    
    NSString *bundle = OCFStrWithFmt(@"%@://", kOCFSchemeFrame);
    if ([urlString hasPrefix:bundle]) {
        return [self ocf_imageInFrame:[urlString substringFromIndex:bundle.length]];
    }
    
    NSString *resource = OCFStrWithFmt(@"%@://", kOCFSchemeResource);
    if ([urlString hasPrefix:resource]) {
        return [self ocf_imageInResource:[urlString substringFromIndex:resource.length]];
    }
    
    NSString *documents = OCFStrWithFmt(@"%@://", kOCFSchemeDocuments);
    if ([urlString hasPrefix:documents]) {
        return [self ocf_imageInDocuments:[urlString substringFromIndex:documents.length]];
    }
    
    return nil;
}

+ (UIImage *)ocf_imageInAsset:(NSString *)name {
    if (name.length == 0) {
        return nil;
    }
    
    return [UIImage imageNamed:name];
}

+ (UIImage *)ocf_imageInFrame:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    
    NSArray *arr = [path componentsSeparatedByString:@"/"];
    if (arr.count != 2) {
        return nil;
    }
    
    NSString *module = arr[0];
    NSString *name = arr[1];
    
    NSBundle *bundle = [NSBundle ocf_bundleWithModule:module];
    UIImage *image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    if (image) {
        return image;
    }
    
    bundle = [NSBundle bundleWithPath:[bundle pathForResource:module ofType:@"bundle"]];
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}

+ (UIImage *)ocf_imageInResource:(NSString *)name {
    if (name.length == 0) {
        return nil;
    }
    
    NSArray *arr = [name componentsSeparatedByString:@"."];
    if (arr.count != 2) {
        return nil;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:arr[0] ofType:arr[1]];
    if (filePath.length == 0) {
        return nil;
    }
    
    return [UIImage imageWithContentsOfFile:filePath];
}

+ (UIImage *)ocf_imageInDocuments:(NSString *)name {
    if (name.length == 0) {
        return nil;
    }
    
    NSString *filePath = [NSString ocf_filePathInDocuments:name];
    if (filePath.length == 0) {
        return nil;
    }
    
    return [UIImage imageWithContentsOfFile:filePath];
}

@end
