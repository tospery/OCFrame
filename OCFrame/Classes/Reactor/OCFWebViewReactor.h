//
//  OCFWebViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFViewReactor.h"
#import "OCFEmptyReactor.h"

@interface OCFWebViewReactor : OCFViewReactor
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSArray *appHandlers;
@property (nonatomic, strong, readonly) UIColor *progressColor;
@property (nonatomic, strong, readonly) OCFEmptyReactor *emptyReactor;

@end

