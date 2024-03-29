//
//  OCFViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFViewReactor.h"
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteHandler.h>
#import <JLRoutes/JLRRouteDefinition.h>
#import <OCFrame/OCFExtensions.h>
#import "OCFAppDependency.h"
#import "OCFParameter.h"
#import "OCFViewController.h"

@interface OCFViewReactor ()
@property (nonatomic, strong, readwrite) NSString *host;
@property (nonatomic, strong, readwrite) NSString *path;
@property (nonatomic, strong, readwrite) NSURL *url;
@property (nonatomic, assign, readwrite) BOOL animated;
@property (nonatomic, assign, readwrite) BOOL transparetNavBar;
@property (nonatomic, assign, readwrite) OCFForwardType forwardType;
@property (nonatomic, strong, readwrite) OCFUser *user;
@property (nonatomic, strong, readwrite) OCFProvider *provider;
@property (nonatomic, strong, readwrite) NSDictionary *parameters;
@property (nonatomic, strong, readwrite) RACSubject *errors;
@property (nonatomic, strong, readwrite) RACSubject *navigate;
@property (nonatomic, strong, readwrite) RACSubject *loading;
@property (nonatomic, strong, readwrite) RACSubject *executing;
@property (nonatomic, strong, readwrite) RACSubject *result;
@property (nonatomic, strong, readwrite) RACSubject *back;
@property (nonatomic, strong, readwrite) RACCommand *loadCommand;
@property (nonatomic, strong, readwrite) id<RACSubscriber> subscriber;

@end

@implementation OCFViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super init]) {
        self.parameters = parameters;
        self.animated = OCFBoolMember(parameters, OCFParameter.animated, YES);
        self.forwardType = OCFForwardTypeWithDft(OCFIntMember(parameters, OCFParameter.forward, 0), 0);
        self.transparetNavBar = OCFBoolMember(parameters, OCFParameter.transparetNavBar, NO);
        self.hidesNavigationBar = OCFBoolMember(parameters, OCFParameter.hidesNavigationBar, NO);
        self.hidesNavBottomLine = OCFBoolMember(parameters, OCFParameter.hidesNavBottomLine, NO);
        self.title = OCFStrMember(parameters, OCFParameter.title, nil);
        self.animation = OCFStrMember(parameters, OCFParameter.animation, nil);
        // Host/Path
        self.url = OCFObjWithDft(OCFURLMember(parameters, JLRouteURLKey, nil), OCFURLMember(parameters, OCFParameter.url, nil));
        self.host = self.url.host;
        self.path = self.url.path;
        // subscriber
        id subscriber = OCFObjMember(parameters, OCFParameter.subscriber, nil);
        if (subscriber && [subscriber conformsToProtocol:@protocol(RACSubscriber)]) {
            self.subscriber = (id<RACSubscriber>)subscriber;
        }
//        // Model
//        id model = OCFObjMember(parameters, OCFParameter.model, nil);
//        if (model && [model isKindOfClass:NSString.class]) {
//            NSDictionary *json = [model ocf_JSONObject];
//            if (json && [json isKindOfClass:NSDictionary.class]) {
//                Class class = NSClassFromString([NSStringFromClass(self.class) stringByReplacingOccurrencesOfString:@"ViewReactor" withString:@""]);
//                if (class && [class conformsToProtocol:@protocol(MTLJSONSerializing)]) {
//                    model = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:json error:nil];
//                }
//            }
//        }
//        self.model = model;
        // User
        NSDictionary *json = OCFStrMember(parameters, OCFParameter.user, nil).ocf_JSONObject;
        if (json && [json isKindOfClass:NSDictionary.class]) {
            Class class = NSClassFromString(@"User");
            if (class && [class conformsToProtocol:@protocol(MTLJSONSerializing)]) {
                self.user = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:json error:nil];
            } else {
                self.user = [OCFUser current];
            }
        } else {
            Class class = NSClassFromString(@"User");
            if (class && [class isSubclassOfClass:OCFModel.class]) {
                self.user = [class current];
            } else {
                self.user = [OCFUser current];
            }
        }
    }
    return self;
}

- (instancetype)initWithRouteParameters:(NSDictionary<NSString *,id> *)parameters {
    if (self = [self initWithParameters:parameters]) {
    }
    return self;
}

- (void)didInit {
    [super didInit];
    @weakify(self)
    RAC(self, dataSource) = [self.loadCommand.executionSignals.switchToLatest map:^id(id data) {
        @strongify(self)
        return [self data2Source:data];
    }];
}

- (void)dealloc {
    OCFLogDebug(@"%@已析构", self.ocf_className);
}

#pragma mark - Property
- (OCFProvider *)provider {
    if (!_provider) {
        _provider = OCFAppDependency.sharedInstance.provider;
    }
    return _provider;
}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (RACSubject *)loading {
    if (!_loading) {
        _loading = [RACSubject subject];
    }
    return _loading;
}

// YJX_TODO 改名为activing
- (RACSubject *)executing {
    if (!_executing) {
        _executing = [RACSubject subject];
    }
    return _executing;
}

- (RACSubject *)navigate {
    if (!_navigate) {
        _navigate = [RACSubject subject];
    }
    return _navigate;
}

- (RACSubject *)result {
    if (!_result) {
        _result = [RACSubject subject];
    }
    return _result;
}

- (RACSubject *)back {
    if (!_back) {
        _back = [RACSubject subject];
    }
    return _back;
}

- (RACCommand *)loadCommand {
    if (!_loadCommand) {
        @weakify(self)
        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[self loadSignal] takeUntil:self.rac_willDeallocSignal];
        }];
        _loadCommand = command;
    }
    return _loadCommand;
}

#pragma mark - Bind
- (void)didBind {
    [super didBind];
    [self.loadCommand execute:nil];
}

#pragma mark - Load
- (RACSignal *)loadSignal {
    return RACSignal.empty;
}

- (id)data2Source:(id)data {
    return data;
}

#pragma mark - Class
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFViewReactor *reactor = [super allocWithZone:zone];
    @weakify(reactor)
    [[reactor rac_signalForSelector:@selector(initWithParameters:)] subscribeNext:^(id x) {
        @strongify(reactor)
        [reactor didInit];
    }];
    return reactor;
}

@end
