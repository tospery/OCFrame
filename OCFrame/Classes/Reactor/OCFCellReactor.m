//
//  OCFCellReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/24.
//

#import "OCFCellReactor.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface OCFCellReactor ()
@property (nonatomic, strong, readwrite) NSString *mid;
@property (nonatomic, strong, readwrite) OCFBaseModel *model;
@property (nonatomic, strong, readwrite) RACCommand *clickCommand;

@end

@implementation OCFCellReactor
- (instancetype)initWithModel:(OCFBaseModel *)model {
    if (self = [self initWithMid:model.mid]) {
        self.model = model;
    }
    return self;
}

- (instancetype)initWithMid:(NSString *)mid {
    if (self = [super init]) {
        self.mid = mid;
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
    OCFCellReactor *item = [super allocWithZone:zone];
    @weakify(item)
    [[item rac_signalForSelector:@selector(initWithModel:)] subscribeNext:^(id x) {
        @strongify(item)
        [item didInitialize];
    }];
    return item;
}

@end
