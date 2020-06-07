//
//  OCFBaseSessionManager.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseSessionManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "OCFType.h"
#import "OCFFunction.h"
#import "OCFBaseResponse.h"
#import "OCFBaseList.h"
#import "NSError+OCFrame.h"

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
            if (response.code != OCFErrorCodeSuccess) {
                return [RACSignal error:[NSError ocf_errorWithCode:response.code description:response.message]];
            }
            if ([response.result isKindOfClass:OCFBaseList.class] &&
                [(OCFBaseList *)response.result items].count == 0) {
                return [RACSignal error:[NSError ocf_errorWithCode:OCFErrorCodeEmpty]];
            }
            return [RACSignal return:response.result];
        };
    }
    return self;
}

- (RACSignal *)get:(NSString *)URLString parameters:(NSDictionary *)parameters {
//    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [[[self rac_GET:URLString parameters:parameters] flattenMap:self.mapBlock] subscribeNext:^(id responseObject) {
//            [subscriber sendNext:responseObject];
//            [subscriber sendCompleted];
//        } error:^(NSError * _Nullable error) {
//            [[RACScheduler currentScheduler] afterDelay:0.5 schedule:^{
//                [subscriber sendError:error];
//            }];
//        }];
//        return [RACDisposable disposableWithBlock:^{
//        }];
//    }] retry:1];
    
    return [[self rac_GET:URLString parameters:parameters progress:nil] flattenMap:self.mapBlock];
}

@end

