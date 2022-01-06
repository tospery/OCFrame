//
//  OCFPageIndicatorComponentView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "OCFPageIndicatorProtocol.h"

typedef NS_ENUM(NSInteger, OCFPageComponentPosition){
    OCFPageComponentPositionBottom,
    OCFPageComponentPositionTop
};

@interface OCFPageIndicatorComponentView : UIView <OCFPageIndicatorProtocol>
@property (nonatomic, assign) OCFPageComponentPosition componentPosition;
@property (nonatomic, assign) CGFloat verticalMargin;     //垂直方向边距；默认：0
@property (nonatomic, assign) BOOL scrollEnabled;   //手势滚动、点击切换的时候，是否允许滚动，默认YES

@end
