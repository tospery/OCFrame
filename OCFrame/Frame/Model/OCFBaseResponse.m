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
- (instancetype)init {
    if (self = [super init]) {
        // 用于没有code/message/data层的数据
        self.code = OCFErrorCodeNone;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"code": @"code",
        @"message": @"message"
    };
}

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary resultClass:(Class)resultClass {
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
