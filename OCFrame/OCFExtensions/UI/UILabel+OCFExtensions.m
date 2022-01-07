//
//  UILabel+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "UILabel+OCFExtensions.h"

@implementation UILabel (OCFExtensions)

+ (CGSize)ocf_sizeAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size limitedToNumberOfLines:(NSInteger)lines {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = lines;
    label.attributedText = attributedString;
    return [label sizeThatFits:size];
}

@end
