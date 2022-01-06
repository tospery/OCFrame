//
//  OCFPageViewReactor.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFScrollViewReactor.h"

// YJX_TODO 将DataSource提到Reactor

@class OCFPageViewReactor;

@protocol OCFPageViewReactorDataSource <OCFScrollViewReactorDataSource>

@end

@interface OCFPageViewReactor : OCFScrollViewReactor <OCFPageViewReactorDataSource>
@property (nonatomic, assign) NSInteger selectIndex;

@end

