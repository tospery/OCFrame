//
//  OCFPageTitleMenuCellModel.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageIndicatorMenuCellModel.h"

@interface OCFPageTitleMenuCellModel : OCFPageIndicatorMenuCellModel
@property (nonatomic, strong) id title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *titleSelectedFont;
@property (nonatomic, assign) BOOL titleLabelMaskEnabled;
@property (nonatomic, strong) CALayer *backgroundEllipseLayer;
@property (nonatomic, assign) BOOL titleLabelZoomEnabled;
@property (nonatomic, assign) CGFloat titleLabelZoomScale;

@end
