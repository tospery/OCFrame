//
//  OCFBaseReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <Foundation/Foundation.h>

@interface OCFBaseReactor : NSObject

- (void)didInitialize; // YJX_TODO 修改名称为didInit

- (void)willBind;
- (void)didBind;

- (void)unbinded;

@end

