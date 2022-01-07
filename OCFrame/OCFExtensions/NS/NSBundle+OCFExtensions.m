//
//  NSBundle+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSBundle+OCFExtensions.h"
#import "NSString+OCFExtensions.h"

@implementation NSBundle (OCFExtensions)

+ (NSBundle *)ocf_bundleWithModule:(NSString *)module {
//    if (module.length == 0) {
//        return [NSBundle mainBundle];
//    }
//
////    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(module)];
////    if (!bundle) {
////        NSString *identifier = OCFStrWithFmt(@"org.cocoapods.%@", module);
////        bundle = [NSBundle bundleWithIdentifier:identifier];
////    }
//
    NSString *identifier = OCFStrWithFmt(@"org.cocoapods.%@", module);
    NSBundle *bundle = [NSBundle bundleWithIdentifier:identifier];
    return bundle ? bundle : NSBundle.mainBundle;
}

@end
