//
//  UIApplication+OCFExtensions.h
//  Pods
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OCFAppEnvironment){
    OCFAppEnvironmentDebug,
    OCFAppEnvironmentTestFlight,
    OCFAppEnvironmentAppStore
};

/// 对于不可在应用扩展中使用的，采用NS_EXTENSION_UNAVAILABLE_IOS进行标注。
@interface UIApplication (OCFExtensions)
@property (nonatomic, assign, readonly) OCFAppEnvironment ocf_environment;
@property (nonatomic, strong, readonly) NSString *ocf_version;
@property (nonatomic, strong, readonly) NSString *ocf_buildNumber;
@property (nonatomic, strong, readonly) NSString *ocf_urlScheme;
@property (nonatomic, strong, readonly) NSString *ocf_displayName;
@property (nonatomic, strong, readonly) NSString *ocf_teamID;
@property (nonatomic, strong, readonly) NSString *ocf_bundleID;
@property (nonatomic, strong, readonly) NSString *ocf_baseApiUrlString;
@property (nonatomic, strong, readonly) NSString *ocf_baseWebUrlString;

- (NSString *)ocf_urlSchemeWithName:(NSString *)name;

@end

