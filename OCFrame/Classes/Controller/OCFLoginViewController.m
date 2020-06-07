//
//  OCFLoginViewController.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFLoginViewController.h"
#import "OCFLoginViewReactor.h"

@interface OCFLoginViewController ()
@property (nonatomic, strong, readwrite) OCFLoginViewReactor *reactor;

@end

@implementation OCFLoginViewController
@dynamic reactor;

- (instancetype)initWithReactor:(OCFViewReactor *)reactor {
    if (self = [super initWithReactor:reactor]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)bind:(OCFBaseReactor *)reactor {
    [super bind:reactor];
}

@end
