//
//  OCFBaseResponse.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseResponse.h"

@interface OCFBaseResponse ()

@end

@implementation OCFBaseResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"code": @"code",
        @"message": @"message"
    };
}

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"data";
}

- (BOOL)validate:(NSError *__autoreleasing *)error {
    return YES;
}

@end
