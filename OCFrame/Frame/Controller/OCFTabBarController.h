//
//  OCFTabBarController.h
//  OCFrame
//
//  Created by 杨建祥 on 2020/6/8.
//

#import <UIKit/UIKit.h>
#import "OCFReactive.h"
#import "OCFNavigator.h"
#import "OCFTabBarReactor.h"

@interface OCFTabBarController : UITabBarController <UITabBarControllerDelegate, OCFReactive>
@property (nonatomic, strong, readonly) OCFTabBarReactor *reactor;
@property (nonatomic, strong, readonly) OCFNavigator *navigator;

- (instancetype)initWithReactor:(OCFTabBarReactor *)reactor navigator:(OCFNavigator *)navigator;

- (void)setupChildren;

@end

