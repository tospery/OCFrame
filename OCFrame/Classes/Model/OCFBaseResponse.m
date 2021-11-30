//
//  OCFBaseResponse.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseResponse.h"
#import "NSError+OCFrame.h"

@interface OCFBaseResponse ()

@end

@implementation OCFBaseResponse
//- (instancetype)init {
//    if (self = [super init]) {
//        // 用于没有code/message/data层的数据
//        // self.code = OCFErrorCodeSuccess;
//    }
//    return self;
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"code": @"code",
        @"message": @"message"
    };
//    NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
//    return mapping;
}

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"data";
}

//- (BOOL)validate:(NSError *__autoreleasing *)error {
//    return YES;
//}

//- (NSInteger)mappedCode {
//    return self.code.integerValue;
//}
//
//- (NSString *)mappedMessage {
//    return self.message;
//}

@end
