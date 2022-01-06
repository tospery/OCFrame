#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MTLJSONAdapter+OCFCore.h"
#import "MTLModel+OCFCore.h"
#import "NSArray+OCFCore.h"
#import "NSBundle+OCFCore.h"
#import "NSDictionary+OCFCore.h"
#import "NSObject+OCFCore.h"
#import "NSString+OCFCore.h"
#import "NSURL+OCFCore.h"
#import "NSValueTransformer+OCFCore.h"
#import "OCFCore.h"
#import "OCFDefines.h"
#import "OCFStrings.h"

FOUNDATION_EXPORT double OCFrameVersionNumber;
FOUNDATION_EXPORT const unsigned char OCFrameVersionString[];

