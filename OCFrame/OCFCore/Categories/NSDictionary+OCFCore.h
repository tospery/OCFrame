//
//  NSDictionary+OCFCore.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (OCFCore)
@property (nonatomic, strong, readonly) NSString *ocf_queryString;
@property (nonatomic, strong, readonly) NSDictionary *ocf_dictionaryByUnderlineValuesFromCamel;

- (NSString *)ocf_stringForKey:(id)key;
- (NSString *)ocf_stringForKey:(id)key withDefault:(NSString *)dft;
- (NSNumber *)ocf_numberForKey:(id)key;
- (NSNumber *)ocf_numberForKey:(id)key withDefault:(NSNumber *)dft;
- (id)ocf_objectForKey:(id)key;
- (id)ocf_objectForKey:(id)key withDefault:(id)dft;
- (NSArray *)ocf_arrayForKey:(id)key;
- (NSArray *)ocf_arrayForKey:(id)key withDefault:(NSArray *)dft;
- (NSDictionary *)ocf_dictionaryForKey:(id)key;
- (NSDictionary *)ocf_dictionaryForKey:(id)key withDefault:(NSDictionary *)dft;
    
@end

