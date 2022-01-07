//
//  OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "OCFExtensions.h"

@implementation OCFExtensions

+ (NSBundle *)ocfResourcesBundle {
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [NSBundle bundleForClass:self];
        NSString *resourcePath = [mainBundle pathForResource:@"OCFResources" ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    return resourceBundle;
}

@end
