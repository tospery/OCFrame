//
//  OCFTableViewController.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFTableViewController.h"
#import <OCFrame/OCFExtensions.h>
#import "OCFTableCell.h"
#import "OCFTableHeaderFooterView.h"
#import "OCFTableViewReactor.h"

@interface OCFTableViewController ()
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *tableHeaderView;
@property (nonatomic, strong, readwrite) UIView *tableFooterView;
@property (nonatomic, strong, readwrite) OCFTableViewReactor *reactor;

@end

@implementation OCFTableViewController
@dynamic reactor;

#pragma mark - Init
- (instancetype)initWithReactor:(OCFViewReactor *)reactor navigator:(OCFNavigator *)navigator {
    if (self = [super initWithReactor:reactor navigator:navigator]) {
    }
    return self;
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView.emptyDataSetSource = nil;
    _tableView.emptyDataSetDelegate = nil;
    _tableView = nil;
}

#pragma mark - View
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = (UITableView *)self.scrollView;
    self.tableView.dataSource = self.reactor;
    self.tableView.delegate = self;
    
    self.tableHeaderView = [[UIView alloc] init];
    self.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFooterView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexMinimumDisplayRowCount = 20;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kOCFIdentifierTableCell];
    [self.tableView registerClass:OCFTableCell.class forCellReuseIdentifier:OCFTableCell.ocf_reuseId];
    [self.tableView registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:kOCFIdentifierTableHeaderFooter];
    [self.tableView registerClass:OCFTableHeaderFooterView.class forHeaderFooterViewReuseIdentifier:OCFTableHeaderFooterView.ocf_reuseId];
    
    SEL reuseSel = @selector(ocf_reuseId);
    
    {
        // Cell
        NSArray *itemNames = self.reactor.cellMapping.allKeys;
        for (NSString *itemName in itemNames) {
            Class itemCls = NSClassFromString(itemName);
            if (!itemCls) {
                continue;
            }
            
            NSString *cellName = self.reactor.cellMapping[itemName];
            if (cellName.length == 0) {
                continue;
            }
            
            Class cellCls = NSClassFromString(cellName);
            if (!cellCls) {
                continue;
            }
            
            if (![cellCls respondsToSelector:reuseSel]) {
                continue;
            }
            
            NSString *reuseId = ((id (*)(id, SEL))[cellCls methodForSelector:reuseSel])(cellCls, reuseSel);
            if (!reuseId || ![reuseId isKindOfClass:NSString.class] || reuseId.length == 0) {
                continue;
            }
            
            NSString *cellPath = [NSBundle.mainBundle pathForResource:cellName ofType:@"nib"];
            if (cellPath.length == 0) {
                [self.tableView registerClass:cellCls forCellReuseIdentifier:reuseId];
            }else {
                UINib *cellNib = [UINib nibWithNibName:cellName bundle:nil];
                [self.tableView registerNib:cellNib forCellReuseIdentifier:reuseId];
            }
        }
    }
    
    {
        // Header/Footer
        NSMutableArray *names = [NSMutableArray arrayWithArray:self.reactor.headerNames];
        [names addObjectsFromArray:self.reactor.footerNames];
        for (NSString *name in names) {
            Class cls = NSClassFromString(name);
            NSString *reuse = ((id (*)(id, SEL))[cls methodForSelector:reuseSel])(cls, reuseSel);
            [self.tableView registerClass:cls forHeaderFooterViewReuseIdentifier:reuse];
        }
    }
}

#pragma mark - Property
- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    self.scrollView = tableView;
}


#pragma mark - Data
- (void)reloadData {
    [super reloadData];
    [self.tableView reloadData];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate
// YJX_TODO 性能优化，采用rowHeight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return 0;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    OCFTableItem *item = [dataSource tableViewReactor:self.reactor itemAtIndexPath:indexPath];
    Class cls = [dataSource tableViewReactor:self.reactor classForItem:item];
    SEL sel = @selector(ocf_heightWithItem:);
    CGFloat height = 0;
    if ([cls respondsToSelector:sel]) {
        height = ((CGFloat (*)(id, SEL, OCFTableItem *))[cls methodForSelector:sel])(cls, sel, item);
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return nil;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    Class cls = [dataSource tableViewReactor:self.reactor headerClassForSection:section];
    UITableViewHeaderFooterView *view = nil;
    SEL sel = @selector(ocf_reuseId);
    if (cls && [cls respondsToSelector:sel]) {
        NSString *reuseId = ((NSString * (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        if (reuseId.length != 0) {
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
        }
    }
    if (view) {
        [self.reactor configureHeader:view atSection:section];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return nil;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    Class cls = [dataSource tableViewReactor:self.reactor footerClassForSection:section];
    UITableViewHeaderFooterView *view = nil;
    SEL sel = @selector(ocf_reuseId);
    if (cls && [cls respondsToSelector:sel]) {
        NSString *reuseId = ((NSString * (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
        if (reuseId.length != 0) {
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseId];
        }
    }
//    if (view) {
//        [self.reactor configureFooter:view atSection:section];
//    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return 0;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    Class cls = [dataSource tableViewReactor:self.reactor headerClassForSection:section];
    CGFloat height = 0;
    SEL sel = @selector(ocf_heightForSection:);
    if (cls && [cls respondsToSelector:sel]) {
        height = ((CGFloat (*)(id, SEL, NSInteger))[cls methodForSelector:sel])(cls, sel, section);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return 0;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    Class cls = [dataSource tableViewReactor:self.reactor footerClassForSection:section];
    CGFloat height = 0;
    SEL sel = @selector(ocf_heightForSection:);
    if (cls && [cls respondsToSelector:sel]) {
        height = ((CGFloat (*)(id, SEL, NSInteger))[cls methodForSelector:sel])(cls, sel, section);
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![tableView.dataSource conformsToProtocol:@protocol(OCFTableViewReactorDataSource)]) {
        return;
    }
    id<OCFTableViewReactorDataSource> dataSource = (id<OCFTableViewReactorDataSource>)tableView.dataSource;
    OCFTableItem *item = [dataSource tableViewReactor:self.reactor itemAtIndexPath:indexPath];
    [self.reactor.selectCommand execute:RACTuplePack(indexPath, item)];
}

//#pragma mark DZNEmptyDataSetDelegate
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    return self.viewModel.dataSource == nil;
//}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
//    return YES;
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -(self.tableView.contentInset.top - self.tableView.contentInset.bottom) / 2;
//}


@end
