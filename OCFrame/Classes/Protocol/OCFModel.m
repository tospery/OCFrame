//
//  OCFModel.m
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import "OCFModel.h"
#import <PINCache/PINCache.h>
#import "OCFFunction.h"
#import "NSString+OCFrame.h"
#import "NSNumber+OCFrame.h"
#import "NSDictionary+OCFrame.h"
#import "MTLJSONAdapter+OCFrame.h"

NSMutableDictionary *localCurrent = nil;

@concreteprotocol(OCFModel)

#pragma mark - OCFIdentifiable
- (NSString *)id {
    return nil;
}

- (instancetype)initWithID:(NSString *)id {
    return nil;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone {
    return nil;
}

#pragma mark - MTLModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary error:(NSError **)error {
    return nil;
}

- (NSDictionary *)dictionaryValue {
    return nil;
}

- (BOOL)validate:(NSError **)error {
    return NO;
}

- (void)mergeValueForKey:(NSString *)key fromModel:(NSObject<MTLModel> *)model {
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary error:(NSError **)error {
    return nil;
}

+ (NSSet *)propertyKeys {
    return nil;
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

#pragma mark - OCFStorable
#pragma mark Key
+ (NSString *)objectArchiverKey:(NSString *)key {
    NSString *name = NSStringFromClass(self.class);
    if (key.length == 0) {
        return OCFStrWithFmt(@"%@", name);
    }
    return OCFStrWithFmt(@"%@#%@", name, key);
}

+ (NSString *)arrayArchiverKey:(NSString *)key {
    NSString *name = NSStringFromClass(self.class);
    if (key.length == 0) {
        return OCFStrWithFmt(@"%@s", name);
    }
    return OCFStrWithFmt(@"%@s#%@", name, key);
}

#pragma mark Object
+ (void)storeObject:(id<OCFStorable>)object {
    [self storeObject:object withKey:nil];
}

+ (void)storeObject:(id<OCFStorable>)object withKey:(NSString *)key {
    NSString *archiverKey = [self objectArchiverKey:key];
    [PINCache.sharedCache setObject:object forKey:archiverKey];
}

+ (void)eraseObjectForKey:(NSString *)key {
    NSString *archiverKey = [self objectArchiverKey:key];
    [PINCache.sharedCache removeObjectForKey:archiverKey];
}

+ (instancetype)cachedObject {
    return [self cachedObjectWithKey:nil];
}

+ (instancetype)cachedObjectWithKey:(NSString *)key {
    NSString *archiverKey = [self objectArchiverKey:key];
    id<OCFModel> object = [PINCache.sharedCache objectForKey:archiverKey];
    if (!object) {
        NSString *path = [NSBundle.mainBundle pathForResource:archiverKey ofType:@"json"];
        if (path.length != 0) {
            NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
            if (data) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (json && [json isKindOfClass:NSDictionary.class]) {
                    object = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:json error:nil];
                }
            }
        }
    }
    return object;
}

#pragma mark Array
+ (void)storeArray:(NSArray<id<OCFStorable>> *)array {
    [self storeArray:array withKey:nil];
}

+ (void)storeArray:(NSArray<id<OCFStorable>> *)array withKey:(NSString *)key {
    NSString *archiverKey = [self arrayArchiverKey:key];
    [PINCache.sharedCache setObject:array forKey:archiverKey];
}

+ (void)eraseArrayForKey:(NSString *)key {
    NSString *archiverKey = [self arrayArchiverKey:key];
    [PINCache.sharedCache removeObjectForKey:archiverKey];
}

+ (NSArray<id<OCFStorable>> *)cachedArray {
    return [self cachedArrayWithKey:nil];
}

+ (NSArray<id<OCFStorable>> *)cachedArrayWithKey:(NSString *)key {
    NSString *archiverKey = [self arrayArchiverKey:key];
    NSArray<id<OCFStorable>> *array = [PINCache.sharedCache objectForKey:archiverKey];
    if (!array) {
        NSString *path = [NSBundle.mainBundle pathForResource:archiverKey ofType:@"json"];
        if (path.length != 0) {
            NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
            if (data) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (json && [json isKindOfClass:NSArray.class]) {
                    array = [MTLJSONAdapter modelsOfClass:self fromJSONArray:json error:nil];
                }
            }
        }
    }
    return array;
}

#pragma mark - OCFModel
- (BOOL)isValid {
    return self.id.length != 0;
}

+ (instancetype)current {
    if (!localCurrent) {
        localCurrent = [NSMutableDictionary dictionary];
    }
    NSString *archiverKey = [self objectArchiverKey:nil];
    id<OCFModel> obj = [localCurrent ocf_objectForKey:archiverKey];
    if (!obj) {
        obj = [self cachedObject];
        if (!obj) {
            obj = [[self alloc] init];
        }
        [localCurrent setObject:obj forKey:archiverKey];
    }
    return obj;
}

@end

