//
//  NSError+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "NSError+OCFrame.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFString.h"
#import "OCFrameManager.h"
#import "UIImage+OCFrame.h"
#import "UIApplication+OCFrame.h"

@implementation NSError (OCFrame)
- (BOOL)ocf_isNetwork {
    return [self.domain isEqualToString:NSURLErrorDomain];
}

- (BOOL)ocf_isServer {
    // return (self.code > OCFErrorCodeSuccess && self.code <= OCFErrorCodeHTTPVersionNotSupported);
    return self.code == OCFErrorCodeServer;
}

- (NSString *)ocf_retryTitle {
    return kStringReload;
}

- (NSString *)ocf_displayTitle {
    return nil;
}

- (NSString *)ocf_displayMessage {
    NSString *message = nil;
    if (self.ocf_isNetwork) {
        message = kStringNetworkException;
    } else if (self.ocf_isServer) {
        message = kStringServerException;
    } else {
        message = self.localizedDescription;
    }
    return message;
}

- (UIImage *)ocf_displayImage {
    UIImage *image = nil;
    if (self.ocf_isNetwork) {
        image = UIImage.ocf_network;
    } else if (self.ocf_isServer) {
        image = UIImage.ocf_server;
    }
    return image;
}

- (NSError *)ocf_adaptError {
    NSError *error = self;
    switch (self.code) {
            case -1009:
            //error = [NSError ocf_errorWithCode:OCFErrorCodeNetwork];
            break;
            case -1011:
            case -1004:
            case -1001:
            case 3840:
            //error = [NSError ocf_errorWithCode:OCFErrorCodeServer];
            break;
        default:
            break;
    }
    return error;
}

+ (NSError *)ocf_errorWithCode:(NSInteger)code {
    return [NSError ocf_errorWithCode:code description:[self ocf_descriptionWithCode:code]];
}

+ (NSError *)ocf_errorWithCode:(NSInteger)code description:(NSString *)description {
    return [NSError errorWithDomain:UIApplication.sharedApplication.ocf_bundleID code:code userInfo:@{NSLocalizedDescriptionKey: OCFStrWithDft(description, kStringErrorUnknown)}];
}

+ (NSString *)ocf_descriptionWithCode:(NSInteger)code {
    NSString *result = kStringErrorUnknown;
    if (code > OCFErrorCodeNone && code < OCFErrorCodeRedirect) {
        result = kStringErrorRequest;
    } else if (code >= OCFErrorCodeRedirect && code < OCFErrorCodeClient) {
        result = kStringErrorRedirect;
    } else if (code >= OCFErrorCodeClient && code < OCFErrorCodeServer) {
        result = kStringErrorClient;
    } else if (code >= OCFErrorCodeServer && code < OCFErrorCodeIgnore) {
        result = kStringErrorServer;
    } else {
        if (code == OCFErrorCodeIgnore) {
            result = kStringErrorIgnore;
        } else if (code == OCFErrorCodeUnknown) {
            result = kStringErrorUnknown;
        } else if (code == OCFErrorCodeNetwork) {
            result = kStringErrorNetwork;
        } else if (code == OCFErrorCodeNavigation) {
            result = kStringErrorNavigation;
        } else if (code == OCFErrorCodeDataFormat) {
            result = kStringErrorDataFormat;
        } else if (code == OCFErrorCodeListIsEmpty) {
            result = kStringErrorListIsEmpty;
        } else if (code == OCFErrorCodeNotLoginedIn) {
            result = kStringErrorNotLoginedIn;
        }
    }
    return result;
}

@end


//NSString * OCFErrorCodeString(OCFErrorCode code) {
//    NSString *result = kStringErrorUnknown;
////    if (code >= OCFErrorCodeCreated && code <= OCFErrorCodePartialContent) {
////        result = kStringErrorRequest;
////    }else if (code >= OCFErrorCodeMultipleChoices && code <= OCFErrorCodeTemporaryRedirect) {
////        result = kStringErrorRedirect;
////    }else if (code >= OCFErrorCodeBadRequest && code <= OCFErrorCodeExpectationFailed) {
////        result = kStringErrorClient;
////    }else if (code >= OCFErrorCodeInternalServerError && code <= OCFErrorCodeHTTPVersionNotSupported) {
////        result = kStringErrorServer;
////    }
//
////    if (code == OCFErrorCodeUnauthorized) {
////        result = kStringErrorExpired;
////    } else if (code == OCFErrorCodeData) {
////        result = kStringErrorData;
////    } else if (code == OCFErrorCodeEmpty) {
////        result = kStringErrorEmpty;
////    }
//
////    else {
////        switch (code) {
////            case OCFErrorCodePlaceholder: {
////                result = kStringErrorUnknown;
////                break;
////            }
////            case OCFErrorCodeData: {
////                result = kStringErrorData;
////                break;
////            }
////            case OCFErrorCodeLoginUnfinished: {
////                result = kStringLoginUnfinished;
////                break;
////            }
////            case OCFErrorCodeLoginFailure: {
////                result = kStringLoginFailure;
////                break;
////            }
////            case OCFErrorCodeArgumentInvalid: {
////                result = kStringArgumentError;
////                break;
////            }
////            case OCFErrorCodeEmpty: {
////                result = kStringDataEmpty;
////                break;
////            }
////            case OCFErrorCodeLoginHasnotAccount: {
////                result = kStringLoginHasnotAccount;
////                break;
////            }
////            case OCFErrorCodeLoginWrongPassword: {
////                result = kStringLoginWrongPassword;
////                break;
////            }
////            case OCFErrorCodeLoginNotPermission: {
////                result = kStringLoginNotPermission;
////                break;
////            }
////            case OCFErrorCodeSigninFailure: {
////                result = kStringSigninFailure;
////                break;
////            }
////            case OCFErrorCodeLocateClosed: {
////                result = kStringLocateClosed;
////                break;
////            }
////            case OCFErrorCodeLocateDenied: {
////                result = kStringLocateDenied;
////                break;
////            }
////            case OCFErrorCodeLocateFailure: {
////                result = kStringLocateFailure;
////                break;
////            }
////            case OCFErrorCodeDeviceNotSupport: {
////                result = kStringDeviceNotSupport;
////                break;
////            }
////            case OCFErrorCodeFileNotPicture: {
////                result = kStringFileNotPicture;
////                break;
////            }
////            case OCFErrorCodeCheckUpdateFailure: {
////                result = kStringCheckUpdateFailure;
////                break;
////            }
////            case OCFErrorCodeExecuteFailure: {
////                result = kStringExecuteFailure;
////                break;
////            }
////            case OCFErrorCodeActionFailure: {
////                result = kStringActionFailure;
////                break;
////            }
////            case OCFErrorCodeParseFailure: {
////                result = kStringParseFailure;
////                break;
////            }
////            default:
////                break;
////        }
////    }
//
//    return result;
//}
