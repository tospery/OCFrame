//
//  OCFNavigationController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFNavigationController.h"

@interface OCFNavigationController ()

@end

@implementation OCFNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

@end
