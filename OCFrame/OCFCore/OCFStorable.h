//
//  OCFStorable.h
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import <Foundation/Foundation.h>
#import <libextobjc/EXTConcreteProtocol.h>

@protocol OCFStorable

@concrete
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
+ (NSArray *)cachedArray;
+ (NSArray *)cachedArrayWithKey:(NSString *)key;
#pragma mark - Array
+ (instancetype)current;

@end

