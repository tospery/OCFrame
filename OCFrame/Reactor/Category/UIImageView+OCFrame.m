//
//  UIImageView+OCFrame.m
//  OCFrame
//
//  Created by liaoya on 2021/11/5.
//

#import "UIImageView+OCFrame.h"
#import <SDWebImage/SDWebImage.h>
#import "NSURL+OCFrame.h"

@implementation UIImageView (OCFrame)

- (BOOL)ocf_setImageWithSource:(id)source {
    if (!source) {
        return NO;
    }
    if ([source isKindOfClass:UIImage.class]) {
        self.image = (UIImage *)source;
    } else if ([source isKindOfClass:NSURL.class]) {
        [self sd_setImageWithURL:(NSURL *)source];
    } else if ([source isKindOfClass:NSString.class]) {
        NSString *string = (NSString *)source;
        UIImage *icon = [UIImage imageNamed:string];
        if (icon) {
            self.image = icon;
        } else {
            NSURL *url = OCFURLWithStr(string);
            if (url) {
                [self sd_setImageWithURL:url];
            } else {
                return NO;
            }
        }
    }
    return YES;
}

@end
