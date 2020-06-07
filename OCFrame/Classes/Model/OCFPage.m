//
//  OCFPage.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFPage.h"

@interface OCFPage ()

@end

@implementation OCFPage
- (instancetype)init {
    if (self = [super init]) {
        self.start = 1;
        self.size = 20;
        self.style = OCFPageStyleGroup;
    }
    return self;
}

- (void)setStart:(NSInteger)start {
    _start = start;
    self.index = start;
}

@end
