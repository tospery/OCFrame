//
//  OCFLoginViewReactor.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFScrollViewReactor.h"
#import "OCFDefines.h"

@interface OCFLoginViewReactor : OCFScrollViewReactor
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, copy) OCFVoidBlock didLoginBlock;
@property (nonatomic, strong, readonly) RACSignal *validateSignal;

@end

