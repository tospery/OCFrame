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

#import "OCFrame.h"
#import "MTLJSONAdapter+Model.h"
#import "NSValueTransformer+Model.h"
#import "OCFIdentifiable.h"
#import "OCFModel.h"
#import "OCFStorable.h"

FOUNDATION_EXPORT double OCFrameVersionNumber;
FOUNDATION_EXPORT const unsigned char OCFrameVersionString[];

