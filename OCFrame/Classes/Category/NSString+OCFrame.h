//
//  NSString+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

#define OCFStrWithBool(x)                    ((x) ? @"YES" : @"NO")
#define OCFStrWithInt(x)                     ([NSString stringWithFormat:@"%llu", ((unsigned long long)x)])
#define OCFStrWithFlt(x)                     ([NSString stringWithFormat:@"%.2f", (x)])
#define OCFStrWithFmt(fmt, ...)              ([NSString stringWithFormat:(fmt), ##__VA_ARGS__])

@interface NSString (OCFrame)
@property (nonatomic, strong, readonly) NSString *ocf_image;
@property (nonatomic, strong, readonly) NSString *ocf_url;
@property (nonatomic, strong, readonly) NSString *ocf_underlineFromCamel;
@property (nonatomic, strong, readonly) NSString *ocf_camelFromUnderline;

- (NSString *)ocf_urlEncoded;
- (NSString *)ocf_urlDecoded;
- (NSString *)ocf_urlComponentEncoded;
- (NSString *)ocf_urlComponentDecoded;

- (CGSize)ocf_sizeFits:(CGSize)size font:(UIFont *)font lines:(NSInteger)lines;
- (CGFloat)ocf_widthFits:(CGFloat)height font:(UIFont *)font lines:(NSInteger)lines;
- (CGFloat)ocf_heightFits:(CGFloat)width font:(UIFont *)font lines:(NSInteger)lines;

+ (NSString *)ocf_stringWithObject:(id)object;
+ (NSString *)ocf_filePathInDocuments:(NSString *)fileName;

@end

