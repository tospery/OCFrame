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
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFString.h"
#import "OCFAppDependency.h"
#import "OCFParameter.h"
#import "OCFViewController.h"
#import "NSObject+OCFrame.h"
#import "NSDictionary+OCFrame.h"
#import "UIViewController+OCFrame.h"
#import "NSError+OCFrame.h"
#import "NSObject+OCFrame.h"

@interface OCFViewReactor ()
@property (nonatomic, strong, readwrite) NSString *host;
@property (nonatomic, strong, readwrite) NSString *path;
@property (nonatomic, assign, readwrite) BOOL animated;
@property (nonatomic, assign, readwrite) OCFForwardType forwardType;
@property (nonatomic, assign, readwrite) BOOL transparetNavBar;
@property (nonatomic, strong, readwrite) OCFUser *user;
@property (nonatomic, strong, readwrite) OCFProvider *provider;
@property (nonatomic, strong, readwrite) NSDictionary *parameters;
@property (nonatomic, strong, readwrite) OCFBaseModel *model;
//@property (nonatomic, strong, readwrite) OCFNavigator *navigator;
//@property (nonatomic, strong, readwrite) RACCommand *backCommand;
//@property (nonatomic, strong, readwrite) RACCommand *didBackCommand;
// @property (nonatomic, strong, readwrite) RACSubject *load;
@property (nonatomic, strong, readwrite) RACSubject *errors;
@property (nonatomic, strong, readwrite) RACSubject *executing;
@property (nonatomic, strong, readwrite) RACSubject *navigate;
//@property (nonatomic, strong, readwrite) RACSignal *loadSignal;
//@property (nonatomic, strong, readwrite) RACCommand *fetchLocalCommand;
@property (nonatomic, strong, readwrite) RACCommand *requestRemoteCommand;
//@property (nonatomic, strong, readwrite) RACCommand *loadCommand;
@property (nonatomic, strong, readwrite) RACCommand *resultCommand;

@end

@implementation OCFViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super init]) {
        self.parameters = parameters;
        self.animated = OCFBoolMember(parameters, OCFParameter.animated, YES);
        self.forwardType = OCFForwardTypeWithDft(OCFIntMember(parameters, OCFParameter.forward, 0), 0);
        self.shouldFetchLocalData = OCFBoolMember(parameters, OCFParameter.fetchLocalData, YES);
        self.shouldRequestRemoteData = OCFBoolMember(parameters, OCFParameter.requestRemote, NO);
        self.transparetNavBar = OCFBoolMember(parameters, OCFParameter.transparetNavBar, NO);
        self.hidesNavigationBar = OCFBoolMember(parameters, OCFParameter.hidesNavigationBar, NO);
        self.hidesNavBottomLine = OCFBoolMember(parameters, OCFParameter.hidesNavBottomLine, NO);
        self.title = OCFStrMember(parameters, OCFParameter.title, nil);
        self.animation = OCFStrMember(parameters, OCFParameter.animation, nil);
        // Host/Path
        NSURL *routeURL = OCFURLMember(parameters, JLRouteURLKey, nil);
        self.host = routeURL.host;
        self.path = routeURL.path;
        // Model
        id model = OCFObjMember(parameters, OCFParameter.model, nil);
        if (model && [model isKindOfClass:NSString.class]) {
            NSDictionary *json = [model ocf_JSONObject];
            if (json && [json isKindOfClass:NSDictionary.class]) {
                Class class = NSClassFromString([NSStringFromClass(self.class) stringByReplacingOccurrencesOfString:@"ViewReactor" withString:@""]);
                if (class && [class conformsToProtocol:@protocol(MTLJSONSerializing)]) {
                    model = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:json error:nil];
                }
            }
        }
        self.model = model;
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
            if (class && [class isSubclassOfClass:OCFBaseModel.class]) {
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

- (void)didInitialize {
    [super didInitialize];
    @weakify(self)
    RACSignal *requestRemoteSignal = self.requestRemoteCommand.executionSignals.switchToLatest;
    if (self.shouldFetchLocalData && !self.shouldRequestRemoteData) {
        RAC(self, dataSource) = [[RACSignal return:[self fetchLocalData]] map:^id(id data) {
            @strongify(self)
            return [self data2Source:data];
        }];
    } else if (!self.shouldFetchLocalData && self.shouldRequestRemoteData) {
        RAC(self, dataSource) = [requestRemoteSignal map:^id(id data) {
            @strongify(self)
            return [self data2Source:data];
        }];
    } else if (self.shouldFetchLocalData && self.shouldRequestRemoteData) {
        RAC(self, dataSource) = [[requestRemoteSignal startWith:[self fetchLocalData]] map:^id(id data) {
            @strongify(self)
            return [self data2Source:data];
        }];
    }
}

- (void)dealloc {
    OCFLogDebug(@"%@已析构", self.ocf_className);
}

#pragma mark - View
#pragma mark - Property
- (OCFProvider *)provider {
    if (!_provider) {
        _provider = OCFAppDependency.sharedInstance.provider;
    }
    return _provider;
}

//- (RACSubject *)load {
//    if (!_load) {
//        _load = [RACSubject subject];
//    }
//    return _load;
//}

- (RACSubject *)errors {
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

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

//- (RACSignal *)loadSignal {
//    if (!_loadSignal) {
//        RACSignal *signal = nil;
//        if (self.shouldFetchLocalData && !self.shouldRequestRemoteData) {
//            signal = self.fetchLocalCommand.executionSignals.switchToLatest;
//        } else if (!self.shouldFetchLocalData && self.shouldRequestRemoteData) {
//            signal = self.requestRemoteCommand.executionSignals.switchToLatest;
//        } else if (self.shouldFetchLocalData && self.shouldRequestRemoteData) {
//            signal = [RACSignal merge:@[self.fetchLocalCommand.executionSignals.switchToLatest, self.requestRemoteCommand.executionSignals.switchToLatest]];
//        } else {
//            signal = RACSignal.empty;
//        }
//        _loadSignal = signal;
//    }
//    return _loadSignal;
//}

//- (RACCommand *)fetchLocalCommand {
//    if (!_fetchLocalCommand) {
//        @weakify(self)
//        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            @strongify(self)
//            return [RACSignal return:[self fetchLocalData]];
//        }];
//        _fetchLocalCommand = command;
//    }
//    return _fetchLocalCommand;
//}

- (RACCommand *)requestRemoteCommand {
    if (!_requestRemoteCommand) {
        @weakify(self)
        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
            @strongify(self)
            return [[self requestRemoteSignalWithPage:page.integerValue] takeUntil:self.rac_willDeallocSignal];
        }];
        // [[command.errors filter:self.errorFilter] subscribe:self.errors];
        _requestRemoteCommand = command;
    }
    return _requestRemoteCommand;
}

- (RACCommand *)resultCommand {
    if (!_resultCommand) {
        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal return:input];
        }];
        _resultCommand = command;
    }
    return _resultCommand;
}

//- (RACCommand *)loadCommand {
//    if (!_loadCommand) {
//        RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            return [RACSignal return:input];
//        }];
//        _loadCommand = command;
//    }
//    return _loadCommand;
//}

#pragma mark - Data
- (id)fetchLocalData {
    return nil;
}

- (RACSignal *)requestRemoteSignalWithPage:(NSInteger)page {
    return RACSignal.empty;
}

- (NSArray *)data2Source:(id)data {
    return nil;
}

- (void)reload {
    
}

#pragma mark - Class
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFViewReactor *reactor = [super allocWithZone:zone];
    @weakify(reactor)
    [[reactor rac_signalForSelector:@selector(initWithParameters:)] subscribeNext:^(id x) {
        @strongify(reactor)
        [reactor didInitialize];
    }];
    return reactor;
}

@end
