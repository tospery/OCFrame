//
//  OCFEmptyReactor.m
//  OCFrame
//
//  Created by 杨建祥 on 2021/12/25.
//

#import "OCFEmptyReactor.h"
#import "OCFFunction.h"

@interface OCFEmptyReactor ()

@end

@implementation OCFEmptyReactor

- (void)didInit {
    [super didInit];
}

- (void)dealloc {
    OCFLogDebug(@"OCFEmptyReactor已回收");
}

@end
