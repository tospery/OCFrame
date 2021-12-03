//
//  OCFScrollItem.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFScrollItem.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface OCFScrollItem ()
@property (nonatomic, strong, readwrite) OCFScrollModel *model;
@property (nonatomic, strong, readwrite) RACCommand *clickCommand;

@end

@implementation OCFScrollItem
- (instancetype)initWithModel:(OCFScrollModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
    self.clickCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[RACSignal return:input] takeUntil:self.rac_willDeallocSignal];
    }];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    OCFScrollItem *item = [super allocWithZone:zone];
    @weakify(item)
    [[item rac_signalForSelector:@selector(initWithModel:)] subscribeNext:^(id x) {
        @strongify(item)
        [item didInitialize];
    }];
    return item;
}

@end
