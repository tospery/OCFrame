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
#import "NSBundle+OCFCore.h"
#import "NSError+OCFCore.h"
#import "NSObject+OCFCore.h"
#import "NSValueTransformer+OCFCore.h"
#import "OCFCore.h"
#import "OCFDefines.h"
#import "OCFFunctions.h"
#import "OCFIdentifiable.h"
#import "OCFModel.h"
#import "OCFStorable.h"
#import "OCFStrings.h"
#import "OCFBaseList.h"
#import "OCFBaseResponse.h"
#import "OCFBaseSessionManager.h"
#import "OCFNetwork.h"
#import "OCFProvider.h"
#import "OCFReachManager.h"

FOUNDATION_EXPORT double OCFrameVersionNumber;
FOUNDATION_EXPORT const unsigned char OCFrameVersionString[];

