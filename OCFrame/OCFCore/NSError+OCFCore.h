//
//  NSError+OCFCore.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OCFErrorCode){
    OCFErrorCodeNone = 200,
    OCFErrorCodeCancel = 10000,      // App自定义错误
    OCFErrorCodeUnknown,
    OCFErrorCodeTimeout,
    OCFErrorCodeNetwork,
    OCFErrorCodeServer,
    OCFErrorCodeArgument,
    OCFErrorCodeNavigation,
    OCFErrorCodeDataFormat,
    OCFErrorCodeListIsEmpty,
    OCFErrorCodeLoginExpired,
    OCFErrorCodeNotLoginedIn
};

@interface NSError (OCFCore)

+ (NSError *)ocf_errorWithCode:(NSInteger)code;
+ (NSError *)ocf_errorWithCode:(NSInteger)code title:(NSString *)title message:(NSString *)message;

@end

