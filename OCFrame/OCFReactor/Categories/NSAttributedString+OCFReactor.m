//
//  NSAttributedString+OCFReactor.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSAttributedString+OCFReactor.h"

@implementation NSAttributedString (OCFReactor)

+ (NSAttributedString *)ocf_attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font {
    if (!string || ![string isKindOfClass:NSString.class]) {
        return nil;
    }
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    if (color) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    return [[NSAttributedString alloc] initWithString:string attributes:attributes];
}

@end
