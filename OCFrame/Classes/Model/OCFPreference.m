//
//  OCFPreference.m
//  OCFrame
//
//  Created by liaoya on 2021/11/15.
//

#import "OCFPreference.h"

@interface OCFPreference ()
@property (nonatomic, assign, readwrite) BOOL isCleanInstall;
@property (nonatomic, strong, readwrite) NSString *appVersion;

@end

@implementation OCFPreference
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithID:(NSString *)id {
    if (self = [super initWithID:id]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    if (self = [super initWithDictionary:dictionaryValue error:error]) {
        [self setup];
    }
    return self;
}

- (void)setup {
//    NSString *version = UIApplication.sharedApplication.ocf_version;
//    if (!self.appVersion) {
//        self.appVersion = version;
//        self.isCleanInstall = YES;
//        return;
//    }
}

@end
