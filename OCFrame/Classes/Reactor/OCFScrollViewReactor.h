//
//  OCFScrollViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFViewReactor.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "OCFPage.h"

@class OCFScrollViewReactor;

@protocol OCFScrollViewReactorDataSource <OCFViewReactorDataSource, DZNEmptyDataSetSource>

@end

@interface OCFScrollViewReactor : OCFViewReactor <OCFScrollViewReactorDataSource>
@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldScrollToMore;
@property (nonatomic, assign) BOOL hasMoreData;
@property (nonatomic, strong, readonly) OCFPage *page;
@property (nonatomic, strong, readonly) RACCommand *selectCommand;

- (NSInteger)offsetForPage:(NSInteger)page;
- (NSInteger)nextPageIndex;

@end

