//
//  OCFPageBaseMenuCell.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "OCFPageBaseMenuCellModel.h"

typedef NS_ENUM(NSUInteger, OCFPageMenuCellState) {
    OCFPageMenuCellStateSelected,
    OCFPageMenuCellStateNormal,
};

@interface OCFPageBaseMenuCell : UICollectionViewCell
@property (nonatomic, strong) OCFPageBaseMenuCellModel *cellModel;

- (void)initializeViews;
- (void)reloadData:(OCFPageBaseMenuCellModel *)cellModel;

@end
