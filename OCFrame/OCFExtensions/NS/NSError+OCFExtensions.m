////
////  NSError+OCFExtensions.m
////  OCFrame
////
////  Created by liaoya on 2022/1/6.
////
//
//#import "NSError+OCFExtensions.h"
//#import <StoreKit/StoreKit.h>
//#import <ReactiveObjC/ReactiveObjC.h>
//#import <OCFrame/OCFCore.h>
//#import "UIApplication+OCFExtensions.h"
//#import "UIImage+OCFExtensions.h"
//
//@implementation NSError (OCFExtensions)
//
//- (BOOL)ocf_isNetwork {
//    return [self.domain isEqualToString:NSURLErrorDomain];
//}
//
//- (BOOL)ocf_isServer {
//    return self.code == OCFErrorCodeServer;
//}
//
//- (BOOL)ocf_isCancelled {
//    if ([self.domain isEqualToString:SKErrorDomain]) {
//        if (self.code == SKErrorPaymentCancelled) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//// @property (nonatomic, assign, readonly) BOOL ocf_isCancelled;
//
//- (NSString *)ocf_titleWhenFailureReasonEmpty {
//    NSString *title = nil;
//    if ([self.domain isEqualToString:NSURLErrorDomain]) {
//        if (self.code == -1009) {
//            title = kStringErrorNetworkTitle;
//        }
//    } else if ([self.domain isEqualToString:RACSignalErrorDomain]) {
//        if (self.code == RACSignalErrorTimedOut) {
//            title = kStringErrorTimeoutTitle;
//        } else if (self.code == RACSignalErrorNoMatchingCase) {
//            title = kStringErrorDataFormatTitle;
//        }
//    }
//    return title;
//}
//
//- (NSString *)ocf_messageWhenDescriptionEmpty {
//    NSString *message = nil;
//    if ([self.domain isEqualToString:NSURLErrorDomain]) {
//        if (self.code == -1009) {
//            message = kStringErrorNetworkMessage;
//        }
//    } else if ([self.domain isEqualToString:RACSignalErrorDomain]) {
//        if (self.code == RACSignalErrorTimedOut) {
//            message = kStringErrorTimeoutMessage;
//        } else if (self.code == RACSignalErrorNoMatchingCase) {
//            message = kStringErrorDataFormatMessage;
//        }
//    }
//    return message;
//}
//
//- (UIImage *)ocf_displayImage {
//    UIImage *image = nil;
//    if (self.ocf_isNetwork) {
//        image = UIImage.ocf_network;
//    } else if (self.ocf_isServer) {
//        image = UIImage.ocf_server;
//    }
//    return image;
//}
//
//
//@end
