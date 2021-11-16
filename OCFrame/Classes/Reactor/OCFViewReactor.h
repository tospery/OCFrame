//
//  OCFViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRRouteHandler.h>
#import "OCFUser.h"
#import "OCFProvider.h"

typedef NS_ENUM(NSInteger, OCFRequestMode) {
    OCFRequestModeNone,
    OCFRequestModeLoad,
    OCFRequestModeUpdate,
    OCFRequestModeRefresh,
    OCFRequestModeMore,
    OCFRequestModeActivity
};

@class OCFViewReactor;

@protocol OCFViewReactorDataSource <NSObject, JLRRouteHandlerTarget>

@end

/// 业务逻辑（网络请求/数据处理）
@interface OCFViewReactor : OCFBaseReactor <OCFViewReactorDataSource>
@property (nonatomic, assign, readonly) BOOL transparetNavBar;
@property (nonatomic, assign) BOOL hidesNavigationBar;
@property (nonatomic, assign) BOOL hidesNavBottomLine;
@property (nonatomic, assign) BOOL shouldFetchLocalData;
@property (nonatomic, assign) BOOL shouldRequestRemoteData;
@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *animation;
@property (nonatomic, strong, readonly) OCFUser *user;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) OCFRequestMode requestMode;
@property (nonatomic, strong, readonly) NSDictionary *parameters;
@property (nonatomic, strong, readonly) OCFProvider *provider;
// @property (nonatomic, strong, readonly) RACSubject *load;
@property (nonatomic, strong, readonly) RACSubject *errors;
@property (nonatomic, strong, readonly) RACSubject *executing;
@property (nonatomic, strong, readonly) RACSubject *navigate;
//@property (nonatomic, strong, readonly) RACSignal *loadSignal;
//@property (nonatomic, strong, readonly) RACCommand *loadCommand;
@property (nonatomic, strong, readonly) RACCommand *resultCommand;
//@property (nonatomic, strong, readonly) RACCommand *fetchLocalCommand;
@property (nonatomic, strong, readonly) RACCommand *requestRemoteCommand;

- (id)fetchLocalData;
- (RACSignal *)requestRemoteSignalWithPage:(NSInteger)page;

- (NSArray *)data2Source:(id)data;
- (void)reload;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithParameters:(NSDictionary *)parameters;

@end

