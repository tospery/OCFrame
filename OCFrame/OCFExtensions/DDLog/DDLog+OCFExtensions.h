//
//  DDLog+OCFExtensions.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

extern DDLogLevel ddLogLevel;

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

@interface DDLog (OCFExtensions)

@end

