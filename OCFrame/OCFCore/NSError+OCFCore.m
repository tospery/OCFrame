//
//  NSError+OCFCore.m
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import "NSError+OCFCore.h"
#import "NSBundle+OCFCore.h"
#import "OCFStrings.h"
#import "OCFFunctions.h"

@implementation NSError (OCFCore)

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
    return [NSError errorWithDomain:NSBundle.mainBundle.ocf_identifier
                               code:code
                           userInfo:@{
        NSLocalizedFailureReasonErrorKey: OCFStrWithDft(title, kStringErrorUnknown),
        NSLocalizedDescriptionKey: OCFStrWithDft(message, kStringErrorUnknown)
    }];
}

@end
