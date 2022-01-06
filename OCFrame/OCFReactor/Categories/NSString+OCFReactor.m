//
//  NSString+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSString+OCFReactor.h"
#import <QMUIKit/QMUIKit.h>
#import "NSURL+OCFReactor.h"
#import "UIApplication+OCFReactor.h"

@implementation NSString (OCFReactor)

- (NSString *)ocf_underlineFromCamel {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

- (NSString *)ocf_camelFromUnderline {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

- (NSString *)ocf_base64Encoded {
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}

- (NSString *)ocf_base64Decoded {
    NSData *base64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *plainData = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    return [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
}

- (NSString *)ocf_urlEncoded {
    NSString *str = [self ocf_urlDecoded]; // 避免两次encode
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, NULL, kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return result;
}

- (NSString *)ocf_urlDecoded {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *result = CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return result;
}

- (NSString *)ocf_urlComponentEncoded {
    NSString *str = [self ocf_urlComponentDecoded]; // 避免两次encode
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)str, NULL,(CFStringRef)@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`",kCFStringEncodingUTF8));
#pragma clang diagnostic pop
    return result;
}

- (NSString *)ocf_urlComponentDecoded {
    return [self ocf_urlDecoded];
}

+ (NSString *)ocf_filePathInDocuments:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:fileName];
}

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

- (NSURL *)ocf_routerURL {
//    NSURL *url = [self ocf_urlWithString:universal];
    

    NSURL *url = OCFURLWithStr(self);
    if (!(!url || url.scheme.length == 0 || url.host.length == 0)) {
        return url;
    }
    NSString *hostpath = self;
    if ([hostpath hasPrefix:@"/"]) {
        hostpath = [hostpath substringFromIndex:1];
    }
    NSString *urlString = OCFStrWithFmt(@"%@://%@", UIApplication.sharedApplication.ocf_urlScheme, hostpath);
    return OCFURLWithStr(urlString);
}

- (NSAttributedString *)ocf_attributedString {
    return [[NSAttributedString alloc] initWithString:self];
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

@end
