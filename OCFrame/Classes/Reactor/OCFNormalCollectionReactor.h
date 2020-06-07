//
//  OCFNormalCollectionReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFCollectionReactor.h"
#import "OCFNormalCollectionModel.h"

@interface OCFNormalCollectionReactor : OCFCollectionReactor
@property (nonatomic, strong, readonly) OCFNormalCollectionModel *model;

@end

