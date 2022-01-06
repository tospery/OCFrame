//
//  OCFPageBaseMenuCellModel.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageBaseMenuCellModel.h"

@interface OCFPageBaseMenuCellModel ()

@end

@implementation OCFPageBaseMenuCellModel

- (CGFloat)cellWidth {
    if (_cellWidthZoomEnabled) {
        return _cellWidth * _cellWidthZoomScale;
    }
    return _cellWidth;
}

@end
