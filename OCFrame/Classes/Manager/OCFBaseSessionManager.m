//
//  OCFBaseSessionManager.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseSessionManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFString.h"
#import "OCFBaseResponse.h"
#import "OCFBaseList.h"
#import "NSError+OCFrame.h"
#import "UIApplication+OCFrame.h"

typedef RACSignal *(^MapBlock)(OCFBaseResponse *);

@interface OCFBaseSessionManager ()
@property(nonatomic, copy) MapBlock mapBlock;

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
            OCFLogDebug(@"restful response: %@", response.rawResult);
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
    }
    return self;
}

- (RACSignal *)get:(NSString *)URLString parameters:(NSDictionary *)parameters {
    return [[self rac_GET:URLString parameters:parameters progress:nil] flattenMap:self.mapBlock];
}

- (RACSignal *)post:(NSString *)URLString
             parameters:(NSDictionary *)parameters
               progress:(id<RACSubscriber>)progress {
    return [[self rac_POST:URLString parameters:parameters progress:progress] flattenMap:self.mapBlock];
}

- (RACSignal *)post:(NSString *)URLString
             parameters:(NSDictionary *)parameters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
               progress:(id<RACSubscriber>)progress {
    return [[self rac_POST:URLString parameters:parameters constructingBodyWithBlock:block progress:progress] flattenMap:self.mapBlock];
}

@end

