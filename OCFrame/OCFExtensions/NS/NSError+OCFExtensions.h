//
//  NSError+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
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

@interface NSError (OCFExtensions)
@property (nonatomic, assign, readonly) BOOL ocf_isNetwork;
@property (nonatomic, assign, readonly) BOOL ocf_isServer;
@property (nonatomic, assign, readonly) BOOL ocf_isCancelled;
@property (nonatomic, strong, readonly) NSString *ocf_titleWhenFailureReasonEmpty;
@property (nonatomic, strong, readonly) NSString *ocf_messageWhenDescriptionEmpty;
@property (nonatomic, strong, readonly) UIImage *ocf_displayImage;

+ (NSError *)ocf_errorWithCode:(NSInteger)code;
+ (NSError *)ocf_errorWithCode:(NSInteger)code title:(NSString *)title message:(NSString *)message;

@end

