//
//  NSObject+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

@interface NSObject (OCFrame)
@property (nonatomic, strong, readonly) NSString *ocf_className;
@property (nonatomic, strong, readonly) id ocf_JSONObject;
@property (nonatomic, strong, readonly) NSData *ocf_JSONData;
@property (nonatomic, strong, readonly) NSString *ocf_JSONString;
@property (class, strong, readonly) NSString *ocf_className;

- (NSString *)ocf_JSONString:(BOOL)prettyPrinted;

@end

