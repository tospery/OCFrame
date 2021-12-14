//
//  OCFTableViewController.h
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFScrollViewController.h"

@interface OCFTableViewController : OCFScrollViewController <UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) UIView *tableHeaderView;
@property (nonatomic, strong, readonly) UIView *tableFooterView;

@end
