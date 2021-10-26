//
//  OCFBaseSessionManager.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <RESTful/RESTful.h>

@interface OCFBaseSessionManager : RESTHTTPSessionManager

- (RACSignal *)get:(NSString *)URLString parameters:(NSDictionary *)parameters;

@end

