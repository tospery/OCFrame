//
//  OCFBaseList.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseList.h"

@interface OCFBaseList ()
@property (nonatomic, assign, readwrite) BOOL hasNext;
@property (nonatomic, assign, readwrite) NSInteger count;
@property (nonatomic, strong, readwrite) NSArray *items;

@end

@implementation OCFBaseList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
    mapping = [mapping mtl_dictionaryByRemovingValuesForKeys:@[@"id"]];
    return mapping;
}

@end
