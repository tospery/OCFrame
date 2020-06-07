//
//  OCFType.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#ifndef OCFType_h
#define OCFType_h

#pragma mark - Block类型
typedef void        (^OCFVoidBlock)(void);
typedef BOOL        (^OCFBoolBlock)(void);
typedef NSInteger   (^OCFIntBlock) (void);
typedef id          (^OCFIdBlock)  (void);

typedef void        (^OCFVoidBlock_bool)(BOOL);
typedef BOOL        (^OCFBoolBlock_bool)(BOOL);
typedef NSInteger   (^OCFIntBlock_bool) (BOOL);
typedef id          (^OCFIdBlock_bool)  (BOOL);

typedef void        (^OCFVoidBlock_int)(NSInteger);
typedef BOOL        (^OCFBoolBlock_int)(NSInteger);
typedef NSInteger   (^OCFIntBlock_int) (NSInteger);
typedef id          (^OCFIdBlock_int)  (NSInteger);

typedef void        (^OCFVoidBlock_string)(NSString *);
typedef BOOL        (^OCFBoolBlock_string)(NSString *);
typedef NSInteger   (^OCFIntBlock_string) (NSString *);
typedef id          (^OCFIdBlock_string)  (NSString *);

typedef void        (^OCFVoidBlock_id)(id);
typedef BOOL        (^OCFBoolBlock_id)(id);
typedef NSInteger   (^OCFIntBlock_id) (id);
typedef id          (^OCFIdBlock_id)  (id);

#endif /* OCFType_h */
