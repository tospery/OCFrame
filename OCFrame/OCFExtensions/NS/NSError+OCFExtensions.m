//
//  NSError+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSError+OCFExtensions.h"
#import <StoreKit/StoreKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <OCFrame/OCFCore.h>
#import "UIApplication+OCFExtensions.h"
#import "UIImage+OCFExtensions.h"

@implementation NSError (OCFExtensions)

- (BOOL)ocf_isNetwork {
    return [self.domain isEqualToString:NSURLErrorDomain];
}

- (BOOL)ocf_isServer {
    return self.code == OCFErrorCodeServer;
}

- (BOOL)ocf_isCancelled {
    if ([self.domain isEqualToString:SKErrorDomain]) {
        if (self.code == SKErrorPaymentCancelled) {
            return YES;
        }
    }
    return NO;
}

// @property (nonatomic, assign, readonly) BOOL ocf_isCancelled;

- (NSString *)ocf_titleWhenFailureReasonEmpty {
    NSString *title = nil;
    if ([self.domain isEqualToString:NSURLErrorDomain]) {
        if (self.code == -1009) {
            title = kStringErrorNetworkTitle;
        }
    } else if ([self.domain isEqualToString:RACSignalErrorDomain]) {
        if (self.code == RACSignalErrorTimedOut) {
            title = kStringErrorTimeoutTitle;
        } else if (self.code == RACSignalErrorNoMatchingCase) {
            title = kStringErrorDataFormatTitle;
        }
    }
    return title;
}

- (NSString *)ocf_messageWhenDescriptionEmpty {
    NSString *message = nil;
    if ([self.domain isEqualToString:NSURLErrorDomain]) {
        if (self.code == -1009) {
            message = kStringErrorNetworkMessage;
        }
    } else if ([self.domain isEqualToString:RACSignalErrorDomain]) {
        if (self.code == RACSignalErrorTimedOut) {
            message = kStringErrorTimeoutMessage;
        } else if (self.code == RACSignalErrorNoMatchingCase) {
            message = kStringErrorDataFormatMessage;
        }
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

//- (NSError *)ocf_adaptError {
//    NSError *error = self;
//    switch (self.code) {
//            case -1009:
//            //error = [NSError ocf_errorWithCode:OCFErrorCodeNetwork];
//            break;
//            case -1011:
//            case -1004:
//            case -1001:
//            case 3840:
//            //error = [NSError ocf_errorWithCode:OCFErrorCodeServer];
//            break;
//        default:
//            break;
//    }
//    return error;
//}

+ (NSError *)ocf_errorWithCode:(NSInteger)code {
    NSString *title = nil;
    NSString *message = nil;
    if (code == OCFErrorCodeCancel) {
        title = kStringErrorCancel;
        message = kStringErrorCancel;
    } else if (code == OCFErrorCodeUnknown) {
        title = kStringErrorUnknown;
        message = kStringErrorUnknown;
    } else if (code == OCFErrorCodeTimeout) {
        title = kStringErrorTimeoutTitle;
        message = kStringErrorTimeoutMessage;
    } else if (code == OCFErrorCodeNetwork) {
        title = kStringErrorNetworkTitle;
        message = kStringErrorNetworkMessage;
    } else if (code == OCFErrorCodeServer) {
        title = kStringErrorServerTitle;
        message = kStringErrorServerMessage;
    } else if (code == OCFErrorCodeArgument) {
        title = kStringErrorArgumentTitle;
        message = kStringErrorArgumentMessage;
    } else if (code == OCFErrorCodeNavigation) {
        title = kStringErrorNavigationTitle;
        message = kStringErrorNavigationMessage;
    } else if (code == OCFErrorCodeDataFormat) {
        title = kStringErrorDataFormatTitle;
        message = kStringErrorDataFormatMessage;
    } else if (code == OCFErrorCodeListIsEmpty) {
        title = kStringErrorListIsEmptyTitle;
        message = kStringErrorListIsEmptyMessage;
    } else if (code == OCFErrorCodeLoginExpired) {
        title = kStringErrorLoginExpiredTitle;
        message = kStringErrorLoginExpiredMessage;
    } else if (code == OCFErrorCodeNotLoginedIn) {
        title = kStringErrorNotLoginedInTitle;
        message = kStringErrorNotLoginedInMessage;
    }
    return [self ocf_errorWithCode:code title:title message:message];
}

+ (NSError *)ocf_errorWithCode:(NSInteger)code title:(NSString *)title message:(NSString *)message {
    return [NSError errorWithDomain:UIApplication.sharedApplication.ocf_bundleID
                               code:code
                           userInfo:@{
        NSLocalizedFailureReasonErrorKey: OCFStrWithDft(title, kStringErrorUnknown),
        NSLocalizedDescriptionKey: OCFStrWithDft(message, kStringErrorUnknown)
    }];
}


@end