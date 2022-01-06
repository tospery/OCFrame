//
//  NSMutableAttributedString+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSMutableAttributedString+OCFReactor.h"
#import "NSAttributedString+OCFReactor.h"

@implementation NSMutableAttributedString (OCFReactor)

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
