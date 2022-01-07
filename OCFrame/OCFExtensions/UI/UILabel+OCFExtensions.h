//
//  UILabel+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

@interface UILabel (OCFExtensions)

+ (CGSize)ocf_sizeAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size limitedToNumberOfLines:(NSInteger)lines;

@end

