//
//  UILabel+OCFrame.m
//  OCFrame
//
//  Created by 杨建祥 on 2021/12/5.
//

#import "UILabel+OCFrame.h"

@implementation UILabel (OCFrame)

+ (CGSize)ocf_sizeAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size limitedToNumberOfLines:(NSInteger)lines {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = lines;
    label.attributedText = attributedString;
    return [label sizeThatFits:size];
}

@end
