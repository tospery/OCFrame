//
//  OCFCollectionCell.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>
#import "OCFReactive.h"
#import "OCFCollectionItem.h"

@interface OCFCollectionCell : UICollectionViewCell <OCFReactive>
@property (nonatomic, strong, readonly) OCFCollectionItem *reactor;

@end

