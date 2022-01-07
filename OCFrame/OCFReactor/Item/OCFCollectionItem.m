//
//  OCFCollectionItem.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionItem.h"
#import <OCFrame/OCFCore.h>

@interface OCFCollectionItem ()

@end

@implementation OCFCollectionItem

- (instancetype)initWithModel:(OCFModel *)model {
    if (self = [super initWithModel:model]) {
        //self.cellSize = CGSizeMake(DEVICE_WIDTH, OCFMetric(44));
    }
    return self;
}

- (void)didInit {
    [super didInit];
}

@end
