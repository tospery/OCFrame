//
//  UIApplication+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

@interface UIApplication (OCFrame)
@property (nonatomic, strong, readonly) NSString *ocf_version;
@property (nonatomic, strong, readonly) NSString *ocf_urlScheme;
@property (nonatomic, strong, readonly) NSString *ocf_displayName;
@property (nonatomic, strong, readonly) NSString *ocf_teamID;
@property (nonatomic, strong, readonly) NSString *ocf_bundleID;

- (NSString *)ocf_urlSchemeWithName:(NSString *)name;

@end

