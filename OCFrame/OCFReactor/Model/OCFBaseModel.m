////
////  OCFModel.m
////  Pods
////
////  Created by 杨建祥 on 2020/2/22.
////
//
//#import "OCFModel.h"
////#import <PINCache/PINCache.h>
////#import "OCFDefines.h"
////#import "NSString+OCFReactor.h"
////#import "NSNumber+OCFReactor.h"
////#import "NSDictionary+OCFReactor.h"
////#import "MTLJSONAdapter+OCFReactor.h"
//
////NSMutableDictionary *currents = nil;
//
//@interface OCFModel () {
//    NSString *_id;
//}
//@property (nonatomic, strong, readwrite) NSString *id;
//
//@end
//
//@implementation OCFModel
//@synthesize id = _id;
//
//- (instancetype)initWithID:(NSString *)id {
//    if (self = [super init]) {
//        self.id = id;
//    }
//    return self;
//}
//
////- (BOOL)isValid {
////    return self.id.length != 0;
////}
////
////#pragma mark - Save
////- (void)save {
////    [self saveWithKey:self.id];
////}
////
////- (void)saveWithKey:(NSString *)key {
////    [PINCache.sharedCache setObject:self forKey:[self.class objectArchiverKey:key]];
////}
////
////#pragma mark - Class
////#pragma mark json
////+ (NSDictionary *)JSONKeyPathsByPropertyKey {
////    return [NSDictionary mtl_identityPropertyMapWithModel:self];
////}
////
////+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
////    return @{
////        @"id": [MTLJSONAdapter NSStringJSONTransformer]
////    }[key];
////}
////
////#pragma mark store
////+ (void)storeObject:(OCFModel *)object {
////    [object saveWithKey:object.id];
////}
////
////+ (void)storeObject:(OCFModel *)object withKey:(NSString *)key {
////    [object saveWithKey:key];
////}
////
////+ (void)storeArray:(NSArray *)array {
////    [self storeArray:array withKey:nil];
////}
////
////+ (void)storeArray:(NSArray *)array withKey:(NSString *)key {
////    [PINCache.sharedCache setObject:array forKey:[self arrayArchiverKey:key]];
////}
////
////#pragma mark erase
////+ (void)eraseObject:(OCFModel *)object {
////    [self eraseObjectForKey:object.id];
////}
////
////+ (void)eraseObjectForKey:(NSString *)key {
////    NSString *archiverKey = [self objectArchiverKey:key];
////    [PINCache.sharedCache removeObjectForKey:archiverKey];
////}
////
////+ (void)eraseArray {
////    [self eraseArrayForKey:nil];
////}
////
////+ (void)eraseArrayForKey:(NSString *)key {
////    NSString *archiverKey = [self arrayArchiverKey:key];
////    [PINCache.sharedCache removeObjectForKey:archiverKey];
////}
////
////#pragma mark cache
////+ (instancetype)cachedObject {
////    return [self cachedObjectWithKey:nil];
////}
////
////+ (instancetype)cachedObjectWithKey:(NSString *)key {
////    NSString *archiverKey = [self objectArchiverKey:key];
////    OCFModel *object = [PINCache.sharedCache objectForKey:archiverKey];
////    if (!object) {
////        NSString *path = [NSBundle.mainBundle pathForResource:archiverKey ofType:@"json"];
////        if (path.length != 0) {
////            NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
////            if (data) {
////                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////                if (json && [json isKindOfClass:NSDictionary.class]) {
////                    object = [MTLJSONAdapter modelOfClass:self fromJSONDictionary:json error:nil];
////                }
////            }
////        }
////    }
////    return object;
////}
////
////+ (NSArray *)cachedArray {
////    return [self cachedArrayWithKey:nil];
////}
////
////+ (NSArray *)cachedArrayWithKey:(NSString *)key {
////    NSString *archiverKey = [self arrayArchiverKey:key];
////    NSArray *array = [PINCache.sharedCache objectForKey:archiverKey];
////    if (!array) {
////        NSString *path = [NSBundle.mainBundle pathForResource:archiverKey ofType:@"json"];
////        if (path.length != 0) {
////            NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
////            if (data) {
////                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////                if (json && [json isKindOfClass:NSArray.class]) {
////                    array = [MTLJSONAdapter modelsOfClass:self fromJSONArray:json error:nil];
////                }
////            }
////        }
////    }
////    return array;
////}
////
////#pragma mark key
////+ (NSString *)objectArchiverKey:(NSString *)key {
////    NSString *name = NSStringFromClass(self.class);
////    if (key.length == 0) {
////        return OCFStrWithFmt(@"%@", name);
////    }
////
////    return OCFStrWithFmt(@"%@#%@", name, key);
////}
////
////+ (NSString *)arrayArchiverKey:(NSString *)key {
////    NSString *name = NSStringFromClass(self.class);
////    if (key.length == 0) {
////        return OCFStrWithFmt(@"%@s", name);
////    }
////    return OCFStrWithFmt(@"%@s#%@", name, key);
////}
////
////#pragma mark current
////+ (instancetype)current {
////    if (!currents) {
////        currents = [NSMutableDictionary dictionary];
////    }
////    NSString *key = [self objectArchiverKey:nil];
////    OCFModel *obj = [currents ocf_objectForKey:key];
////    if (!obj) {
////        obj = [self cachedObject];
////        if (!obj) {
////            obj = [[self alloc] init];
////        }
////        [currents setObject:obj forKey:key];
////    }
////    return obj;
////}
//
//@end
