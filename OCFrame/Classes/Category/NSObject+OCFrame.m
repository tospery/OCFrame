//
//  NSObject+OCFrame.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "NSObject+OCFrame.h"
#import <Mantle/Mantle.h>

@implementation NSObject (OCFrame)

#pragma mark - Instance
- (NSString *)ocf_className {
    return self.class.ocf_className;
}

- (id)ocf_JSONObject {
    if ([self isKindOfClass:NSString.class]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }
    
    if ([self isKindOfClass:NSData.class]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    
    if ([self isKindOfClass:NSDictionary.class]) {
        return self;
    }
    
    if ([self conformsToProtocol:@protocol(MTLJSONSerializing)]) {
        id<MTLJSONSerializing> model = (id<MTLJSONSerializing>)self;
        return [MTLJSONAdapter JSONDictionaryFromModel:model error:nil];
    }
    
    if ([self isKindOfClass:NSArray.class]) {
        id json = [MTLJSONAdapter JSONArrayFromModels:(NSArray *)self error:nil];
        if (!json) {
            json = self;
        }
        return json;
    }
    
    return nil;
}

- (NSData *)ocf_JSONData {
    return [self ocf_JSONData:NO];
}

- (NSData *)ocf_JSONData:(BOOL)prettyPrinted {
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    return [NSJSONSerialization dataWithJSONObject:self.ocf_JSONObject options:(prettyPrinted ? NSJSONWritingPrettyPrinted : kNilOptions) error:nil];
}

- (NSString *)ocf_JSONString:(BOOL)prettyPrinted {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    return [[NSString alloc] initWithData:[self ocf_JSONData:prettyPrinted] encoding:NSUTF8StringEncoding];
}

- (NSString *)ocf_JSONString {
    return [self ocf_JSONString:NO];
}

#pragma mark - Class
+ (NSString *)ocf_className {
    return NSStringFromClass(self);
}

@end
