//
//  NSMutableAttributedString+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSMutableAttributedString+OCFExtensions.h"
#import "NSAttributedString+OCFExtensions.h"

@implementation NSMutableAttributedString (OCFExtensions)

- (void)ocf_setupAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = alignment;
    paragraphStyle.lineSpacing = lineSpacing;
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)ocf_appendNextLine {
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (void)ocf_appendString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    [self appendAttributedString:[NSAttributedString ocf_attributedStringWithString:string color:color font:font]];
}


@end
