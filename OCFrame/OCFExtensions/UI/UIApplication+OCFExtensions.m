//
//  UIApplication+OCFExtensions.m
//  Pods
//
//  Created by liaoya on 2022/1/6.
//

#import "UIApplication+OCFExtensions.h"
#import <OCFrame/OCFCore.h>
#import "NSString+OCFExtensions.h"

@implementation UIApplication (OCFExtensions)

static NSInteger ocfEnvironment = -1;
- (OCFAppEnvironment)ocf_environment {
    if (ocfEnvironment != -1) {
        return ocfEnvironment;
    }
#ifdef DEBUG
    ocfEnvironment = OCFAppEnvironmentDebug;
#elif defined(TARGET_OS_SIMULATOR)
    ocfEnvironment = OCFAppEnvironmentDebug;
#else
    NSString *path = [NSBundle.mainBundle pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (path.length != 0) {
        ocfEnvironment = OCFAppEnvironmentTestFlight;
    } else {
        NSURL *appStoreReceiptUrl = NSBundle.mainBundle.appStoreReceiptURL;
        if (!appStoreReceiptUrl) {
            ocfEnvironment = OCFAppEnvironmentDebug;
        } else {
            if ([appStoreReceiptUrl.lastPathComponent.lowercaseString isEqualToString:@"sandboxreceipt"]) {
                ocfEnvironment = OCFAppEnvironmentTestFlight;
            } else if ([appStoreReceiptUrl.path.lowercaseString containsString:@"simulator"]) {
                ocfEnvironment = OCFAppEnvironmentDebug;
            } else {
                ocfEnvironment = OCFAppEnvironmentAppStore;
            }
        }
    }
#endif
    return ocfEnvironment;
}


- (NSString *)ocf_version {
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

static NSString *ocfURLScheme = nil;
- (NSString *)ocf_urlScheme {
    if (!ocfURLScheme) {
        ocfURLScheme = [self ocf_urlSchemeWithName:@"app"];
    }
    return ocfURLScheme;
}

- (NSString *)ocf_displayName {
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)ocf_buildNumber {
    return [NSBundle.mainBundle.infoDictionary objectForKey:(__bridge NSString *)kCFBundleVersionKey];
}

- (NSString *)ocf_teamID {
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount : @"bundleSeedID",
                            (__bridge id)kSecAttrService : @"",
                            (__bridge id)kSecReturnAttributes : (__bridge id)kCFBooleanTrue};
    
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound) {
        status = SecItemAdd((CFDictionaryRef)query, (CFTypeRef *)&result);
    }
    
    if (status != errSecSuccess) {
        return nil;
    }
    
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    
    return bundleSeedID;
}

- (NSString *)ocf_bundleID {
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)ocf_urlSchemeWithName:(NSString *)name {
    NSArray *urlTypes = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleURLTypes"];
    NSString *scheme = nil;
    for (NSDictionary *info in urlTypes) {
        NSString *urlName = [info objectForKey:@"CFBundleURLName"];
        if ([urlName isEqualToString:name]) {
            NSArray *urlSchemes = [info objectForKey:@"CFBundleURLSchemes"];
            scheme = urlSchemes.firstObject;
            break;
        }
    }
    return scheme;
}

- (NSString *)ocf_baseApiUrlString {
    return OCFStrWithFmt(@"https://api.%@.com", self.ocf_urlScheme);
}

- (NSString *)ocf_baseWebUrlString {
    return OCFStrWithFmt(@"https://m.%@.com", self.ocf_urlScheme);
}

@end
