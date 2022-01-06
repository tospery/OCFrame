//
//  OCFBaseReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <Foundation/Foundation.h>

@interface OCFBaseReactor : NSObject

- (void)didInit;

- (void)willBind;
- (void)didBind;

- (void)unbinded;

@end

