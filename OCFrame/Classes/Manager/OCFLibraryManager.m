//
//  OCFLibraryManager.m
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import "OCFLibraryManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <JLRoutes/JLRoutes.h>
#import "OCFConstant.h"

@interface OCFLibraryManager ()

@end

@implementation OCFLibraryManager

- (void)setup {
    //[self setupJLRoutes];
    //[self setupToast];
}

//- (void)setupJLRoutes {
//    @weakify(self)
//    [JLRoutes.globalRoutes addRoute:kOCFHostToast handler:^BOOL(NSDictionary *parameters) {
//        OCFVoidBlock_id completion = OCFObjMember(parameters, OCFParameter.block, nil);
//        @strongify(self)
//        return [self.navigator.topView ocf_toastWithParameters:parameters completion:^(BOOL didTap) {
//            if (completion) {
//                completion(@(didTap));
//            }
//        }];
//    }];
//}

//- (void)setupToast {
//    [CSToastManager setQueueEnabled:YES];
//    [CSToastManager setDefaultPosition:CSToastPositionCenter];
//}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

@end
