//
//  OCFPageIndicatorMenuCellModel.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageBaseMenuCellModel.h"

@interface OCFPageIndicatorMenuCellModel : OCFPageBaseMenuCellModel
@property (nonatomic, assign) BOOL sepratorLineShowEnabled;
@property (nonatomic, strong) UIColor *separatorLineColor;
@property (nonatomic, assign) CGSize separatorLineSize;
@property (nonatomic, assign) CGRect backgroundViewMaskFrame;
@property (nonatomic, assign) BOOL cellBackgroundColorGradientEnabled;
@property (nonatomic, strong) UIColor *cellBackgroundUnselectedColor;
@property (nonatomic, strong) UIColor *cellBackgroundSelectedColor;

@end
