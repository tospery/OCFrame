//
//  NSMutableAttributedString+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (OCFReactor)

- (void)ocf_setupAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing;

- (void)ocf_appendNextLine;
- (void)ocf_appendString:(NSString *)string color:(UIColor *)color font:(UIFont *)font;

@end

