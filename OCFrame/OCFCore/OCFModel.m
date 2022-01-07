//
//  OCFModel.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "OCFModel.h"
#import "MTLJSONAdapter+OCFCore.h"

@interface OCFModel () {
    NSString *_id;
}
@property (nonatomic, strong, readwrite) NSString *id;

@end

@implementation OCFModel
@synthesize id = _id;

- (instancetype)initWithID:(NSString *)id {
    if (self = [super init]) {
        self.id = id;
    }
    return self;
}

- (BOOL)isValid {
    return self.id.length != 0;
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    return @{
        @"id": [MTLJSONAdapter NSStringJSONTransformer]
    }[key];
}

@end
