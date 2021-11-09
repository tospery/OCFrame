//
//  OCFCollectionItem.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionItem.h"
#import "OCFFunction.h"

@interface OCFCollectionItem ()

@end

@implementation OCFCollectionItem
- (instancetype)initWithModel:(OCFBaseModel *)model {
    if (self = [super initWithModel:model]) {
        //self.cellSize = CGSizeMake(DEVICE_WIDTH, OCFMetric(44));
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
}

@end
