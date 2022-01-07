//
//  OCFReactiveView.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFReactiveView.h"
#import <OCFrame/OCFExtensions.h>

@interface OCFReactiveView ()
@property (nonatomic, strong, readwrite) OCFBaseReactor *reactor;

@end

@implementation OCFReactiveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.ocf_background;
    }
    return self;
}

- (void)bind:(OCFBaseReactor *)reactor { 
    self.reactor = reactor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
