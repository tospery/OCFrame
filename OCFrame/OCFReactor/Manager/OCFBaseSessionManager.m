//
//  OCFBaseSessionManager.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseSessionManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFDefines.h"
#import "OCFDefines.h"
#import "OCFDefines.h"
#import "OCFStrings.h"
#import "OCFBaseResponse.h"
#import "OCFBaseList.h"
#import "NSError+OCFReactor.h"
#import "UIApplication+OCFReactor.h"
#import "NSObject+OCFReactor.h"

typedef RACSignal *(^MapBlock)(OCFBaseResponse *);
typedef void (^ErrBlock)(NSError *);

@interface OCFBaseSessionManager ()
@property(nonatomic, copy) MapBlock mapBlock;
@property(nonatomic, copy) ErrBlock errBlock;

@end

@implementation OCFBaseSessionManager
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        NSMutableSet *contentTypes = [self.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObjectsFromArray:@[
            @"text/html",
            @"application/javascript"
        ]];
        self.responseSerializer.acceptableContentTypes = contentTypes;
        self.mapBlock = ^RACSignal *(OCFBaseResponse *response) {
            OCFLogDebug(@"restful response: %@", [response.rawResult ocf_JSONString:YES]);
            if (response.code != OCFErrorCodeNone) {
                return [RACSignal error:[NSError errorWithDomain:UIApplication.sharedApplication.ocf_bundleID code:response.code userInfo:@{
                    NSLocalizedDescriptionKey: OCFStrWithDft(response.message, kStringErrorUnknown),
                    kOCFErrorResponse: response.rawResult
                }]];
            }
            if ([response.result isKindOfClass:OCFBaseList.class] &&
                [(OCFBaseList *)response.result items].count == 0) {
                return [RACSignal error:[NSError ocf_errorWithCode:OCFErrorCodeListIsEmpty]];
            }
            return [RACSignal return:response.result];
        };
        self.errBlock = ^(NSError *error) {
            OCFLogError(@"restful error: %@", error);
        };
    }
    return self;
}

- (RACSignal *)get:(NSString *)URLString parameters:(NSDictionary *)parameters {
    return [[[self rac_GET:URLString parameters:parameters] flattenMap:self.mapBlock] doError:self.errBlock];
}

- (RACSignal *)post:(NSString *)URLString
             parameters:(NSDictionary *)parameters {
    return [[[self rac_POST:URLString parameters:parameters] flattenMap:self.mapBlock] doError:self.errBlock];
}

- (RACSignal *)post:(NSString *)URLString
             parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block {
    return [[[self rac_POST:URLString parameters:parameters constructingBodyWithBlock:block] flattenMap:self.mapBlock] doError:self.errBlock];
}

@end

