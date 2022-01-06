//
//  OCFViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFBaseReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRRouteHandler.h>
#import "OCFDefines.h"
#import "OCFUser.h"
#import "OCFProvider.h"
#import "OCFNavigable.h"

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
@property (nonatomic, strong, readonly) NSDictionary *parameters;
@property (nonatomic, strong, readonly) NSString *host;
@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong, readonly) NSURL *url;

/// 输入参数，用于打开该页面时传递过来的关联model。
@property (nonatomic, strong) OCFModel *model;

@property (nonatomic, assign, readonly) BOOL animated;
@property (nonatomic, assign, readonly) OCFForwardType forwardType;
@property (nonatomic, assign, readonly) BOOL transparetNavBar;
@property (nonatomic, assign) BOOL hidesNavigationBar;
@property (nonatomic, assign) BOOL hidesNavBottomLine;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *animation;
@property (nonatomic, strong, readonly) OCFUser *user;
@property (nonatomic, strong) id dataSource;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) OCFRequestMode requestMode;
@property (nonatomic, strong, readonly) OCFProvider *provider;
@property (nonatomic, strong, readonly) RACSubject *errors;
@property (nonatomic, strong, readonly) RACSubject *navigate;
@property (nonatomic, strong, readonly) RACSubject *loading;
@property (nonatomic, strong, readonly) RACSubject *executing;
@property (nonatomic, strong, readonly) RACSubject *result;
@property (nonatomic, strong, readonly) RACSubject *back;
@property (nonatomic, strong, readonly) RACCommand *loadCommand;
@property (nonatomic, strong, readonly) id<RACSubscriber> subscriber;

- (RACSignal *)loadSignal;

- (id)data2Source:(id)data;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithParameters:(NSDictionary *)parameters;

@end

