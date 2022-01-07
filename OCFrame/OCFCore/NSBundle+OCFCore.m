//
//  NSBundle+OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "NSBundle+OCFCore.h"

@implementation NSBundle (OCFCore)

- (NSString *)ocf_identifier {
    return [self.infoDictionary objectForKey:@"CFBundleIdentifier"];
}

@end
