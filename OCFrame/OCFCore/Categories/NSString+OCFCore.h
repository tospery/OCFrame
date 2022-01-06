//
//  NSString+OCFCore.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

#define OCFStrWithBool(x)                    ((x) ? @"YES" : @"NO")
#define OCFStrWithInt(x)                     ([NSString stringWithFormat:@"%llu", ((unsigned long long)x)])
#define OCFStrWithFlt(x)                     ([NSString stringWithFormat:@"%.2f", (x)])
#define OCFStrWithFmt(fmt, ...)              ([NSString stringWithFormat:(fmt), ##__VA_ARGS__])

@interface NSString (OCFCore)
@property (nonatomic, strong, readonly) NSString *ocf_trim;
@property (nonatomic, strong, readonly) NSString *ocf_underlineFromCamel;
@property (nonatomic, strong, readonly) NSString *ocf_camelFromUnderline;
@property (nonatomic, strong, readonly) NSString *ocf_base64Encoded;
@property (nonatomic, strong, readonly) NSString *ocf_base64Decoded;
@property (nonatomic, strong, readonly) NSString *ocf_urlEncoded;
@property (nonatomic, strong, readonly) NSString *ocf_urlDecoded;
@property (nonatomic, strong, readonly) NSString *ocf_urlComponentEncoded;
@property (nonatomic, strong, readonly) NSString *ocf_urlComponentDecoded;
@property (nonatomic, strong, readonly) NSAttributedString *ocf_attributedString;

+ (NSString *)ocf_filePathInDocuments:(NSString *)fileName;

@end

