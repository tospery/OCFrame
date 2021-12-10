//
//  OCFNormalCollectionModel.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/25.
//

#import "OCFBaseModel.h"

@interface OCFNormalCollectionModel : OCFBaseModel
@property (nonatomic, assign) BOOL indicated;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *target;

@end

