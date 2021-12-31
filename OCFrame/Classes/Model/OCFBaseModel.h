//
//  OCFBaseModel.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import <Mantle_JX/Mantle.h>
#import "OCFIdentifiable.h"

// YJX_TODO 提取Storable，定义BaseModelType，从而可以从BaseResponse从继承满足BaseModel要求的模型
@interface OCFBaseModel : MTLModel <MTLJSONSerializing, OCFIdentifiable>
@property (nonatomic, assign, readonly) BOOL isValid;

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

