//
//  OCFNormalCollectionReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFNormalCollectionReactor.h"
#import "OCFFunction.h"

@interface OCFNormalCollectionReactor ()
@property (nonatomic, strong, readwrite) OCFNormalCollectionModel *model;

@end

@implementation OCFNormalCollectionReactor
@dynamic model;

- (instancetype)initWithModel:(OCFNormalCollectionModel *)model {
    if (self = [super initWithModel:model]) {
        //self.cellSize = CGSizeMake(DEVICE_WIDTH, OCFMetric(50));
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
}

@end
