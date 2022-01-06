//
//  OCFNormalCollectionCell.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFCollectionCell.h"

@interface OCFNormalCollectionCell : OCFCollectionCell
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;
@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;

@end

