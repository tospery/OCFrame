//
//  UIApplication+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OCFAppEnvironment){
    OCFAppEnvironmentDebug,
    OCFAppEnvironmentTestFlight,
    OCFAppEnvironmentAppStore
};

@interface UIApplication (OCFrame)
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

