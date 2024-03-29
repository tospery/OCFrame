//
//  OCFBaseSessionManager.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <Overcoat_JX/Overcoat.h>

@interface OCFBaseSessionManager : OVCHTTPSessionManager

- (RACSignal *)get:(NSString *)URLString parameters:(NSDictionary *)parameters;
- (RACSignal *)post:(NSString *)URLString parameters:(NSDictionary *)parameters;
- (RACSignal *)post:(NSString *)URLString parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;

@end

