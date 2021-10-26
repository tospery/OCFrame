//
//  OCFTabBarController.h
//  OCFrame
//
//  Created by 杨建祥 on 2020/6/8.
//

#import <UIKit/UIKit.h>
#import "OCFTabBarReactor.h"

@interface OCFTabBarController : UITabBarController
@property (nonatomic, strong, readonly) OCFTabBarReactor *reactor;

- (instancetype)initWithReactor:(OCFTabBarReactor *)reactor;

@end

