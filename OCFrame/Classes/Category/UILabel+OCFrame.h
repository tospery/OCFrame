//
//  UILabel+OCFrame.h
//  OCFrame
//
//  Created by 杨建祥 on 2021/12/5.
//

#import <UIKit/UIKit.h>

@interface UILabel (OCFrame)

+ (CGSize)ocf_sizeAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size limitedToNumberOfLines:(NSInteger)lines;

@end

