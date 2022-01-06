//
//  NSBundle+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "NSBundle+OCFrame.h"
#import "NSString+OCFrame.h"

@implementation NSBundle (OCFrame)

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
