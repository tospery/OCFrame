//
//  OCFTabBarViewController.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollViewController.h"
#import "OCFTabBarViewReactor.h"

@interface OCFTabBarViewController : OCFScrollViewController <UITabBarControllerDelegate>
@property (nonatomic, strong, readonly) UITabBarController *innerTabBarController;
@property (nonatomic, strong, readonly) OCFTabBarViewReactor *reactor;

@end

