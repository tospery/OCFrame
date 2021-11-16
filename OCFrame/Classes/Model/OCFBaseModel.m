//
//  OCFBaseModel.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFBaseModel.h"
#import <PINCache/PINCache.h>
#import "OCFFunction.h"
#import "NSString+OCFrame.h"
#import "NSNumber+OCFrame.h"
#import "NSDictionary+OCFrame.h"
#import "MTLJSONAdapter+OCFrame.h"

NSMutableDictionary *currents = nil;

@interface OCFBaseModel () {
    NSString *_id;
}
@property (nonatomic, strong, readwrite) NSString *id;

@end

@implementation OCFBaseModel
@synthesize id = _id;

#pragma mark - Init
- (instancetype)initWithID:(NSString *)id {
    if (self = [super init]) {
        self.id = id;
    }
    return self;
}

#pragma mark - Save
- (void)save {
    [self saveWithKey:self.id];
}

- (void)saveWithKey:(NSString *)key {
    [PINCache.sharedCache setObject:self forKey:[self.class objectArchiverKey:key]];
}

#pragma mark - Class
#pragma mark json
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    return @{
        @"id": [MTLJSONAdapter NSStringJSONTransformer]
    }[key];
}

#pragma mark store
+ (void)storeObject:(OCFBaseModel *)object {
    [object saveWithKey:object.id];
}

+ (void)storeObject:(OCFBaseModel *)object withKey:(NSString *)key {
    [object saveWithKey:key];
}

+ (void)storeArray:(NSArray *)array {
    [PINCache.sharedCache setObject:array forKey:[self arrayArchiverKey]];
}

#pragma mark erase
+ (void)eraseObject:(OCFBaseModel *)object {
    [self eraseObjectForKey:object.id];
}

+ (void)eraseObjectForKey:(NSString *)key {
    NSString *archiverKey = [self objectArchiverKey:key];
    [PINCache.sharedCache removeObjectForKey:archiverKey];
}

+ (void)eraseArray {
    NSString *archiverKey = [self arrayArchiverKey];
    [PINCache.sharedCache removeObjectForKey:archiverKey];
}

#pragma mark cache
+ (instancetype)cachedObject {
    return [self cachedObjectWithKey:nil];
}

+ (instancetype)cachedObjectWithKey:(NSString *)key {
    NSString *archiverKey = [self objectArchiverKey:key];
    OCFBaseModel *object = [PINCache.sharedCache objectForKey:archiverKey];
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

+ (NSArray *)cachedArray {
    NSString *archiverKey = [self arrayArchiverKey];
    NSArray *array = [PINCache.sharedCache objectForKey:archiverKey];
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

#pragma mark key
+ (NSString *)objectArchiverKey:(NSString *)key {
    NSString *name = NSStringFromClass(self.class);
    if (key.length == 0) {
        return OCFStrWithFmt(@"%@", name);
    }
    
    return OCFStrWithFmt(@"%@#%@", name, key);
}

+ (NSString *)arrayArchiverKey {
    return OCFStrWithFmt(@"%@s", NSStringFromClass(self.class));
}

#pragma mark current
+ (instancetype)current {
    if (!currents) {
        currents = [NSMutableDictionary dictionary];
    }
    NSString *key = [self objectArchiverKey:nil];
    OCFBaseModel *obj = [currents ocf_objectForKey:key];
    if (!obj) {
        obj = [self cachedObject];
        if (!obj) {
            obj = [[self alloc] init];
        }
        [currents setObject:obj forKey:key];
    }
    return obj;
}

@end
