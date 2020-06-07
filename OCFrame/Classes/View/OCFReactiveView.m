//
//  OCFReactiveView.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFReactiveView.h"

@interface OCFReactiveView ()
@property (nonatomic, strong, readwrite) OCFBaseReactor *reactor;

@end

@implementation OCFReactiveView

- (void)bind:(OCFBaseReactor *)reactor { 
    self.reactor = reactor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
