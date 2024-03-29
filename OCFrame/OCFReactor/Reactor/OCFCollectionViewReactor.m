//
//  OCFCollectionViewReactor.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionViewReactor.h"
#import <OCFrame/OCFExtensions.h>
#import "OCFReactive.h"
#import "OCFCollectionSupplementary.h"

@interface OCFCollectionViewReactor ()

@end

@implementation OCFCollectionViewReactor

#pragma mark - Init
- (instancetype)initWithParameters:(NSDictionary *)parameters {
    if (self = [super initWithParameters:parameters]) {
    }
    return self;
}

- (void)didInit {
    [super didInit];
}

#pragma mark - View
#pragma mark - Property

#pragma mark - Data
- (id)data2Source:(id)data {
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

#pragma mark - Configure
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withItem:(OCFCollectionItem *)reactor {
    
}

- (void)configureHeader:(UICollectionReusableView *)header atSection:(NSInteger)section {
    
}

- (void)configureFooter:(UICollectionReusableView *)footer atSection:(NSInteger)section {
    
}

#pragma mark - Delegate
#pragma mark OCFCollectionViewModelDataSource
- (OCFCollectionItem *)collectionViewReactor:(OCFCollectionViewReactor *)collectionViewReactor itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.section][indexPath.row];
}

- (Class)collectionViewReactor:(OCFCollectionViewReactor *)collectionViewReactor classForItem:(OCFCollectionItem *)reactor {
    return NSClassFromString([self.cellMapping objectForKey:NSStringFromClass(reactor.class)]);
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [(NSArray *)self.dataSource count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [(NSArray *)self.dataSource[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OCFCollectionItem *reactor = [self collectionViewReactor:self itemAtIndexPath:indexPath];
    Class cls = [self collectionViewReactor:self classForItem:reactor];
    SEL sel = @selector(ocf_reuseId);
    NSString *reuseId = nil;
    if ([cls respondsToSelector:sel]) {
        reuseId = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath withItem:reactor];
    if ([cell conformsToProtocol:@protocol(OCFReactive)]) {
        id<OCFReactive> reactive = (id<OCFReactive>)cell;
        [reactive bind:reactor];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = nil;
    
    BOOL isHeader = YES;
    NSInteger index = self.headerNames.count;
    NSMutableArray *names = [NSMutableArray arrayWithArray:self.headerNames];
    [names addObjectsFromArray:self.footerNames];
    
    for (NSInteger i = 0; i < names.count; ++i) {
        Class cls = NSClassFromString(names[i]);
        if ([cls conformsToProtocol:@protocol(OCFCollectionSupplementary)]) {
            id<OCFCollectionSupplementary> supplementary = (id<OCFCollectionSupplementary>)cls;
            if ([kind isEqualToString:[supplementary kind]]) {
                SEL sel = @selector(ocf_reuseId);
                if ([cls respondsToSelector:sel]) {
                    NSString *reuseId = ((id (*)(id, SEL))[cls methodForSelector:sel])(cls, sel);
                    if (reuseId && [reuseId isKindOfClass:NSString.class] && reuseId.length != 0) {
                        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseId forIndexPath:indexPath];
                        if (view) {
                            isHeader = (i < index);
                            break;
                        }
                    }
                }
            }
        }
    }
    
    if (!view) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kOCFIdentifierCollectionHeader forIndexPath:indexPath];
        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kOCFIdentifierCollectionFooter forIndexPath:indexPath];
            isHeader = NO;
        }
    }
    
    if (view) {
        if (isHeader) {
            [self configureHeader:view atSection:indexPath.section];
        }else {
            [self configureFooter:view atSection:indexPath.section];
        }
    }
    
    return view;
}

#pragma mark - Class

@end
