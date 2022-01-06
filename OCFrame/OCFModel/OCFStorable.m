//
//  OCFStorable.m
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import "OCFStorable.h"
#import <Mantle_JX/Mantle.h>
#import <PINCache/PINCache.h>

NSMutableDictionary *localCurrents = nil;

@concreteprotocol(OCFStorable)

#pragma mark - OCFStorable
#pragma mark Key
+ (NSString *)objectArchiverKey:(NSString *)key {
    NSString *name = NSStringFromClass(self.class);
    if (key.length == 0) {
        return name;
    }
    return [NSString stringWithFormat:@"%@#%@", name, key];
}

+ (NSString *)arrayArchiverKey:(NSString *)key {
    NSString *name = NSStringFromClass(self.class);
    if (key.length == 0) {
        return [NSString stringWithFormat:@"%@s", name];
    }
    return [NSString stringWithFormat:@"%@s#%@", name, key];
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
    id<OCFStorable> object = [PINCache.sharedCache objectForKey:archiverKey];
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
    return (OCFStorable_ProtocolMethodContainer *)object;
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

+ (NSArray *)cachedArray {
    return [self cachedArrayWithKey:nil];
}

+ (NSArray *)cachedArrayWithKey:(NSString *)key {
    NSString *archiverKey = [self arrayArchiverKey:key];
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

#pragma mark Current
+ (instancetype)current {
    if (!localCurrents) {
        localCurrents = [NSMutableDictionary dictionary];
    }
    NSString *archiverKey = [self objectArchiverKey:nil];
    id<OCFStorable> model = [localCurrents objectForKey:archiverKey];
    if (!model) {
        model = [self cachedObject];
        if (!model) {
            model = [[self alloc] init];
        }
        [localCurrents setObject:model forKey:archiverKey];
    }
    return (OCFStorable_ProtocolMethodContainer *)model;
}

@end
