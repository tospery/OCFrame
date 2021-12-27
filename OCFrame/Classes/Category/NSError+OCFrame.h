//
//  NSError+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OCFErrorCode){
    OCFErrorCodeNone = 200,
//    OCFErrorCodeRequest = 201,
//    OCFErrorCodeRedirect = 300,
//    OCFErrorCodeClient = 400,
//    OCFErrorCodeServer = 500,
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
    
//    OCFErrorCodeSuccess = 200,
//    OCFErrorCodeOK = OCFErrorCodeSuccess, // 2xx的状态码表示请求成功
//    OCFErrorCodeCreated,
//    OCFErrorCodeAccepted,
//    OCFErrorCodeNonAuthInfo,
//    OCFErrorCodeNoContent,
//    OCFErrorCodeResetContent,
//    OCFErrorCodePartialContent,
//    OCFErrorCodeMultipleChoices = 300, // 3xxx重定向错误
//    OCFErrorCodeMovedPermanently,
//    OCFErrorCodeFound,
//    OCFErrorCodeSeeOther,
//    OCFErrorCodeNotModified,
//    OCFErrorCodeUseProxy,
//    OCFErrorCodeUnused,
//    OCFErrorCodeTemporaryRedirect,
//    OCFErrorCodeBadRequest = 400,  // 4xx客户端错误
//    OCFErrorCodeUnauthorized,
//    OCFErrorCodePaymentRequired,
//    OCFErrorCodeForbidden,
//    OCFErrorCodeNotFound,
//    OCFErrorCodeMethodNotAllowed,
//    OCFErrorCodeNotAcceptable,
//    OCFErrorCodeProxyAuthRequired,
//    OCFErrorCodeRequestTimeout,
//    OCFErrorCodeConflict,
//    OCFErrorCodeGone,
//    OCFErrorCodeLengthRequired,
//    OCFErrorCodePreconditionFailed,
//    OCFErrorCodeRequestEntityTooLarge,
//    OCFErrorCodeRequestURITooLong,
//    OCFErrorCodeUnsupportedMediaType,
//    OCFErrorCodeRequestedRangeNotSatisfiable,
//    OCFErrorCodeExpectationFailed,
//    OCFErrorCodeInternalServerError = 500, // 5xx服务器错误
//    OCFErrorCodeNotImplemented,
//    OCFErrorCodeBadGateway,
//    OCFErrorCodeServiceUnavailable,
//    OCFErrorCodeGatewayTimeout,
//    OCFErrorCodeHTTPVersionNotSupported,
    //    OCFErrorCodeNetwork,
    //    OCFErrorCodeServer,
//    OCFErrorCodeEmpty,
//    OCFErrorCodeData,
//    OCFErrorCodeLoginUnfinished,
//    OCFErrorCodeLoginFailure,
//    OCFErrorCodeArgumentInvalid,
//    OCFErrorCodeLoginHasnotAccount,
//    OCFErrorCodeLoginWrongPassword,
//    OCFErrorCodeLoginNotPermission,
//    OCFErrorCodeSigninFailure,
//    OCFErrorCodeLocateClosed,
//    OCFErrorCodeLocateDenied,
//    OCFErrorCodeLocateFailure,
//    OCFErrorCodeDeviceNotSupport,
//    OCFErrorCodeFileNotPicture,
//    OCFErrorCodeCheckUpdateFailure,
//    OCFErrorCodeExecuteFailure,
//    OCFErrorCodeActionFailure,
//    OCFErrorCodeParseFailure,
//
//    OCFErrorCodeTotal
};

//NSString * OCFErrorCodeString(OCFErrorCode code);

@interface NSError (OCFrame)
@property (nonatomic, assign, readonly) BOOL ocf_isNetwork;
@property (nonatomic, assign, readonly) BOOL ocf_isServer;
@property (nonatomic, strong, readonly) NSString *ocf_titleWhenFailureReasonEmpty;
@property (nonatomic, strong, readonly) NSString *ocf_messageWhenDescriptionEmpty;
@property (nonatomic, strong, readonly) UIImage *ocf_displayImage;

+ (NSError *)ocf_errorWithCode:(NSInteger)code;
+ (NSError *)ocf_errorWithCode:(NSInteger)code title:(NSString *)title message:(NSString *)message;

@end


