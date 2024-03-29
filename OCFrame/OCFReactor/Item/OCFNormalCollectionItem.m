//
//  OCFNormalCollectionItem.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFNormalCollectionItem.h"
#import <OCFrame/OCFCore.h>

@interface OCFNormalCollectionItem ()
@property (nonatomic, strong, readwrite) OCFNormalCollectionModel *model;

@end

@implementation OCFNormalCollectionItem
@dynamic model;

//- (instancetype)initWithModel:(OCFNormalCollectionModel *)model {
//    if (self = [super initWithModel:model]) {
//        //self.cellSize = CGSizeMake(DEVICE_WIDTH, OCFMetric(50));
//    }
//    return self;
//}

- (instancetype)initWithModel:(OCFModel *)model {
    if (self = [super initWithModel:model]) {
    }
    return self;
}

- (void)didInit {
    [super didInit];
    self.target = self.model.target;
}

@end
