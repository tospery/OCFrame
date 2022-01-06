//
//  OCFStorable.h
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import "OCFIdentifiable.h"
#import <Mantle_JX/Mantle.h>

@protocol OCFStorable <OCFIdentifiable, MTLJSONSerializing>

@required
#pragma mark - Key
+ (NSString *)objectArchiverKey:(NSString *)key;
+ (NSString *)arrayArchiverKey:(NSString *)key;
#pragma mark - Object
+ (void)storeObject:(id<OCFStorable>)object;
+ (void)storeObject:(id<OCFStorable>)object withKey:(NSString *)key;
+ (void)eraseObjectForKey:(NSString *)key;
+ (instancetype)cachedObject;
+ (instancetype)cachedObjectWithKey:(NSString *)key;
#pragma mark - Array
+ (void)storeArray:(NSArray<id<OCFStorable>> *)array;
+ (void)storeArray:(NSArray<id<OCFStorable>> *)array withKey:(NSString *)key;
+ (void)eraseArrayForKey:(NSString *)key;
+ (NSArray<id<OCFStorable>> *)cachedArray;
+ (NSArray<id<OCFStorable>> *)cachedArrayWithKey:(NSString *)key;

@end

