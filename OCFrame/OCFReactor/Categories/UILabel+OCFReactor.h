//
//  UILabel+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

@interface UILabel (OCFReactor)

+ (CGSize)ocf_sizeAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size limitedToNumberOfLines:(NSInteger)lines;

@end

