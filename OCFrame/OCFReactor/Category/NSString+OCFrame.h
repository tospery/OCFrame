//
//  NSString+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

@interface NSString (OCFrame)
@property (nonatomic, strong, readonly) NSString *ocf_image;
@property (nonatomic, strong, readonly) NSURL *ocf_url;

- (CGSize)ocf_sizeFits:(CGSize)size font:(UIFont *)font lines:(NSInteger)lines;
- (CGFloat)ocf_widthFits:(CGFloat)height font:(UIFont *)font lines:(NSInteger)lines;
- (CGFloat)ocf_heightFits:(CGFloat)width font:(UIFont *)font lines:(NSInteger)lines;

- (NSAttributedString *)ocf_attributedStringWithColor:(UIColor *)color font:(UIFont *)font;

@end

