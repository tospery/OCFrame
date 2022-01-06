//
//  NSString+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSString+OCFrame.h"
#import <QMUIKit/QMUIKit.h>
#import "NSAttributedString+OCFrame.h"

@implementation NSString (OCFrame)

#pragma mark - Instance

- (UIImage *)ocf_image {
    return [UIImage imageNamed:self];
}

- (NSURL *)ocf_url {
    NSURL *url = [NSURL URLWithString:self];
    if (url == nil) {
        NSString *raw = self.qmui_trim;
        url = [NSURL URLWithString:raw];
        if (url == nil) {
            url = [NSURL URLWithString:raw.ocf_urlDecoded];
        }
        if (url == nil) {
            url = [NSURL URLWithString:raw.ocf_urlDecoded];
        }
    }
    return url;
}

- (NSAttributedString *)ocf_attributedStringWithColor:(UIColor *)color font:(UIFont *)font {
    return [NSAttributedString ocf_attributedStringWithString:self color:color font:font];
}

- (CGSize)ocf_sizeFits:(CGSize)size font:(UIFont *)font lines:(NSInteger)lines {
    CGSize result = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:(font ? @{NSFontAttributeName: font} : nil) context:nil].size;
    if (font != nil && lines > 0) {
        result.height = MIN(size.height, font.lineHeight * lines);
    }
    return result;
}

- (CGFloat)ocf_widthFits:(CGFloat)height font:(UIFont *)font lines:(NSInteger)lines {
    return ceil([self ocf_sizeFits:CGSizeMake(CGFLOAT_MAX, height) font:font lines:lines].width);
}

- (CGFloat)ocf_heightFits:(CGFloat)width font:(UIFont *)font lines:(NSInteger)lines {
    return ceil([self ocf_sizeFits:CGSizeMake(width, CGFLOAT_MAX) font:font lines:lines].height);
}

#pragma mark - Class

@end
