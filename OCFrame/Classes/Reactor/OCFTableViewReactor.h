//
//  OCFTableViewReactor.h
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFScrollViewReactor.h"
#import "OCFTableItem.h"

@class OCFTableViewReactor;

@protocol OCFTableViewReactorDataSource <OCFScrollViewReactorDataSource, UITableViewDataSource>
- (OCFTableItem *)tableViewReactor:(OCFTableViewReactor *)tableViewReactor itemAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor classForItem:(OCFTableItem *)item;
- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor headerClassForSection:(NSInteger)section;
- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor footerClassForSection:(NSInteger)section;

@end

@interface OCFTableViewReactor : OCFScrollViewReactor <OCFTableViewReactorDataSource>
@property (nonatomic, strong) NSDictionary *cellMapping;
@property (nonatomic, strong) NSArray *headerNames;
@property (nonatomic, strong) NSArray *footerNames;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withItem:(OCFTableItem *)item;
- (void)configureHeader:(UITableViewHeaderFooterView *)header atSection:(NSInteger)section;
- (void)configureFooter:(UITableViewHeaderFooterView *)footer atSection:(NSInteger)section;

@end

