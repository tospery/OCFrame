//
//  OCFTableViewReactor.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFTableViewReactor.h"
#import "OCFConstant.h"
#import "OCFReactive.h"
#import "OCFTableHeaderFooter.h"
#import "NSError+OCFrame.h"
#import "UITableViewCell+OCFrame.h"
#import "UITableViewHeaderFooterView+OCFrame.h"
#import "UITableView+OCFrame.h"
#import "NSArray+OCFrame.h"

@interface OCFTableViewReactor ()

@end

@implementation OCFTableViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
    }
    return self;
}

- (void)didInitialize {
    [super didInitialize];
}

#pragma mark - View
#pragma mark - Property
#pragma mark - Method
- (NSArray *)data2Source:(id)data {
    if (!data || ![data isKindOfClass:NSArray.class]) {
        return nil;
    }
    NSArray *items = (NSArray *)data;
    if (items.count == 0) {
        self.error = [NSError ocf_errorWithCode:OCFErrorCodeListIsEmpty];
        return nil;
    }
    return @[items];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withItem:(OCFTableItem *)item {
    
}

- (void)configureHeader:(UITableViewHeaderFooterView *)header atSection:(NSInteger)section {
    
}

- (void)configureFooter:(UITableViewHeaderFooterView *)footer atSection:(NSInteger)section {
    
}

#pragma mark - Delegate
#pragma mark OCFTableViewReactorDataSource
- (OCFTableItem *)tableViewReactor:(OCFTableViewReactor *)tableViewReactor itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.section][indexPath.row];
}

- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor classForItem:(OCFTableItem *)item {
    return NSClassFromString([self.cellMapping objectForKey:NSStringFromClass(item.class)]);
}

- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor headerClassForSection:(NSInteger)section {
    return NSClassFromString([self.headerNames ocf_objectAtIndex:section]);
}

- (Class)tableViewReactor:(OCFTableViewReactor *)tableViewReactor footerClassForSection:(NSInteger)section {
    return NSClassFromString([self.footerNames ocf_objectAtIndex:section]);
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCFTableItem *item = [self tableViewReactor:self itemAtIndexPath:indexPath];
    Class cls = [self tableViewReactor:self classForItem:item];
    SEL sel = @selector(ocf_reuseId);
    NSString *reuseId = nil;
    if ([cls respondsToSelector:sel]) {
        reuseId = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath withItem:item];
    if ([cell conformsToProtocol:@protocol(OCFReactive)]) {
        id<OCFReactive> reactive = (id<OCFReactive>)cell;
        [reactive bind:item];
    }
    return cell;
}

#pragma mark - Class

@end
