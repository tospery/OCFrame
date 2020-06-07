//
//  OCFBaseModel.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>
#import "OCFIdentifiable.h"

@interface OCFBaseModel : MTLModel <MTLJSONSerializing, OCFIdentifiable>

- (void)save;
- (void)saveWithKey:(NSString *)key;

+ (void)storeObject:(OCFBaseModel *)object;
+ (void)storeObject:(OCFBaseModel *)object withKey:(NSString *)key;
+ (void)storeArray:(NSArray *)array;

+ (void)eraseObject:(OCFBaseModel *)object;
+ (void)eraseObjectForKey:(NSString *)key;
+ (void)eraseArray;

+ (instancetype)cachedObject;
+ (instancetype)cachedObjectWithKey:(NSString *)key;
+ (NSArray *)cachedArray;

+ (instancetype)current;

@end

