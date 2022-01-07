//
//  NSObject+OCFExtensions.m
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "NSObject+OCFExtensions.h"
#import <QMUIKit/QMUIKit.h>
#import <Mantle_JX/Mantle.h>

@implementation NSObject (OCFExtensions)
QMUISynthesizeIdStrongProperty(ocf_tag, setOcf_tag)

#pragma mark - public
+ (NSString *)ocf_className {
    return NSStringFromClass(self);
}

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
        NSArray *array = (NSArray *)self;
        BOOL isModelType = YES;
        for (id obj in array) {
            if (![obj isKindOfClass:NSString.class] &&
                ![obj isKindOfClass:NSNumber.class] &&
                ![obj isKindOfClass:NSDictionary.class]) {
                isModelType = NO;
                break;
            }
            if (![obj conformsToProtocol:@protocol(MTLJSONSerializing)]) {
                isModelType = NO;
                break;
            }
        }
        if (!isModelType) {
            return array;
        }
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

- (NSString *)ocf_JSONString {
    return [self ocf_JSONString:NO];
}

- (NSString *)ocf_JSONString:(BOOL)prettyPrinted {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    return [[NSString alloc] initWithData:[self ocf_JSONData:prettyPrinted] encoding:NSUTF8StringEncoding];
}

#pragma mark - private
- (NSData *)ocf_JSONData:(BOOL)prettyPrinted {
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    return [NSJSONSerialization dataWithJSONObject:self.ocf_JSONObject options:(prettyPrinted ? NSJSONWritingPrettyPrinted : kNilOptions) error:nil];
}

@end
