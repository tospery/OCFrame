////
////  OCFReachManager.m
////  OCFrame
////
////  Created by liaoya on 2021/12/6.
////
//
//#import "OCFReachManager.h"
//#import <AFNetworking/AFNetworking.h>
//
//@interface OCFReachManager ()
//@property (nonatomic, strong, readwrite) RACBehaviorSubject *subject;
//
//@end
//
//@implementation OCFReachManager
//
//- (instancetype)init {
//    if (self = [super init]) {
//    }
//    return self;
//}
//
//- (RACBehaviorSubject *)subject {
//    if (!_subject) {
//        RACBehaviorSubject *subject = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(AFNetworkReachabilityStatusUnknown)];
//        _subject = subject;
//    }
//    return _subject;
//}
//
//+ (instancetype)sharedInstance {
//    static id instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self.class alloc] init];
//    });
//    return instance;
//}
//
//@end
