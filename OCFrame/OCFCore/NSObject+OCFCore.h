//
//  NSObject+OCFCore.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <Foundation/Foundation.h>

@interface NSObject (OCFCore)
@property (class, nonatomic, strong, readonly) NSString *ocf_className;
@property (nonatomic, strong) id ocf_tag;
@property (nonatomic, strong, readonly) NSString *ocf_className;
@property (nonatomic, strong, readonly) id ocf_JSONObject;
@property (nonatomic, strong, readonly) NSData *ocf_JSONData;
@property (nonatomic, strong, readonly) NSString *ocf_JSONString;

- (NSString *)ocf_JSONString:(BOOL)prettyPrinted;

@end

