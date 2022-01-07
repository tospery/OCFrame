//
//  OCFDefines.h
//  Pods
//
//  Created by liaoya on 2022/1/6.
//

#ifndef OCFDefines_h
#define OCFDefines_h

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#pragma mark - 类型
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

#pragma mark - 常量
#pragma mark Identifier
#define kOCFIdentifierTableCell                      (@"kOCFIdentifierTableCell")
#define kOCFIdentifierTableHeaderFooter              (@"kOCFIdentifierTableHeaderFooter")
#define kOCFIdentifierCollectionCell                 (@"kOCFIdentifierCollectionCell")
#define kOCFIdentifierCollectionHeader               (@"kOCFIdentifierCollectionHeader")
#define kOCFIdentifierCollectionFooter               (@"kOCFIdentifierCollectionFooter")

#pragma mark Scheme
#define kOCFSchemeHTTP                              (@"http")
#define kOCFSchemeAsset                             (@"asset")
#define kOCFSchemeFrame                             (@"frame")
#define kOCFSchemeResource                          (@"resource")
#define kOCFSchemeDocuments                         (@"documents")

#pragma mark Host
#define kOCFHostAny                                 (@"*")
#define kOCFHostToast                               (@"toast")
#define kOCFHostAlert                               (@"alert")
#define kOCFHostSheet                               (@"sheet")
#define kOCFHostPopup                               (@"popup")
#define kOCFHostLogin                               (@"login")
#define kOCFHostThirdparty                          (@"thirdparty")

#pragma mark Back
#define kOCFBackAuto                                (@"back")
#define kOCFBackPopone                              (@"back/popone")
#define kOCFBackPopall                              (@"back/popall")
#define kOCFBackDismiss                             (@"back/dismiss")
#define kOCFBackFadeaway                            (@"back/fadeaway")

#pragma mark Animation
//#define kOCFAnimationFade                           (@"fade")
//#define kOCFAnimationGrow                           (@"grow")
//#define kOCFAnimationShrink                         (@"shrink")
//#define kOCFAnimationSlide                          (@"slide")
//#define kOCFAnimationBounce                         (@"bounce")

#pragma mark Log
#define kOCFLogTagTest                              (@"Test")
#define kOCFLogTagNormal                            (@"Normal")
#define kOCFLogTagLibrary                           (@"Library")
#define kOCFLogTagArgument                          (@"Argument")

#pragma mark Convenient
#define kOCFFrameName                               (@"OCFrame")
#define kOCFBindObjectKey                           (@"kOCFBindObjectKey")
#define kOCFErrorResponse                           (@"kOCFErrorResponse")

#pragma mark - 方法
#pragma mark Check
#define OCFCheck(arg)                                           \
if (OCFObjectIsNullOrEmpty(arg)) {                              \
return;                                                         \
}
#define OCFCheckWithResult(arg, ret)                            \
if (OCFObjectIsNullOrEmpty(arg)) {                              \
return ret;                                                     \
}

#pragma mark Random
#define OCFRandomNumber(x, y)                ((NSInteger)((x) + (arc4random() % ((y) - (x) + 1))))

#pragma mark Log
#ifdef DEBUG
#define OCFLogVerbose(fmt, ...)                                                                 \
DDLogVerbose(@"Verbose: " fmt, ##__VA_ARGS__);
#define OCFLogDebug(fmt, ...)                                                                   \
DDLogDebug(@"Debug: " fmt, ##__VA_ARGS__);
#define OCFLogInfo(fmt, ...)                                                                    \
DDLogInfo(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
DDLogWarn(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
DDLogError(@"Error: " fmt, ##__VA_ARGS__);
#else
#define OCFLogVerbose(fmt, ...)
#define OCFLogDebug(fmt, ...)
#define OCFLogInfo(fmt, ...)                                                                    \
DDLogInfo(@"Info: " fmt, ##__VA_ARGS__);
#define OCFLogWarn(fmt, ...)                                                                    \
DDLogWarn(@"Warn: " fmt, ##__VA_ARGS__);
#define OCFLogError(fmt, ...)                                                                   \
DDLogError(@"Error: " fmt, ##__VA_ARGS__);
#endif

#endif /* OCFDefines_h */
