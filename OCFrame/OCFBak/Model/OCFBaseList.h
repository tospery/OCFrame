//
//  OCFBaseList.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseModel.h"

@interface OCFBaseList : OCFBaseModel
@property (nonatomic, assign, readonly) BOOL hasNext;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, strong, readonly) NSArray *items;

@end
