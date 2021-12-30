//
//  OCFPageIndicatorMenuView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageBaseMenuView.h"
#import "OCFPageIndicatorProtocol.h"
#import "OCFPageIndicatorMenuCell.h"
#import "OCFPageIndicatorMenuCellModel.h"

@interface OCFPageIndicatorMenuView : OCFPageBaseMenuView
@property (nonatomic, strong) NSArray <UIView<OCFPageIndicatorProtocol> *> *indicators;

//----------------------ellBackgroundColor-----------------------//
@property (nonatomic, assign) BOOL cellBackgroundColorGradientEnabled;      //默认：NO

@property (nonatomic, strong) UIColor *cellBackgroundUnselectedColor;       //默认：[UIColor clearColor]

@property (nonatomic, strong) UIColor *cellBackgroundSelectedColor;     //默认：[UIColor grayColor]

//----------------------separatorLine-----------------------//
@property (nonatomic, assign) BOOL separatorLineShowEnabled;    //默认为NO

@property (nonatomic, strong) UIColor *separatorLineColor;    //默认为[UIColor lightGrayColor]

@property (nonatomic, assign) CGSize separatorLineSize;    //默认为CGSizeMake(1/[UIScreen mainScreen].scale, 20)

/**
 当contentScrollView滚动时候，处理跟随手势的过渡效果。
 根据cellModel的左右位置、是否选中、ratio进行过滤数据计算。
 
 @param leftCellModel 左边的cellModel
 @param rightCellModel 右边的cellModel
 @param ratio 从左往右方向计算的百分比
 */
- (void)refreshLeftCellModel:(OCFPageBaseMenuCellModel *)leftCellModel rightCellModel:(OCFPageBaseMenuCellModel *)rightCellModel ratio:(CGFloat)ratio;

@end

