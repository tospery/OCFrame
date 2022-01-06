//
//  OCFPageBaseMenuCellModel.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <Foundation/Foundation.h>

@interface OCFPageBaseMenuCellModel : NSObject
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL cellWidthZoomEnabled;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellSpacing;
@property (nonatomic, assign) CGFloat cellWidthZoomScale;

@end
