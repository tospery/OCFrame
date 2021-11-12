//
//  OCFCollectionItem.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFScrollItem.h"
#import "OCFCollectionModel.h"

@interface OCFCollectionItem : OCFScrollItem
@property (nonatomic, strong, readonly) OCFCollectionModel *model;

@end

