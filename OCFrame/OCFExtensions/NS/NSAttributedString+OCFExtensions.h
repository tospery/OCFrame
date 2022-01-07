//
//  NSAttributedString+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (OCFExtensions)

+ (NSAttributedString *)ocf_attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font;

@end

