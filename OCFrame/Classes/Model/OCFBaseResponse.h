//
//  OCFBaseResponse.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <RESTful/RESTful.h>

@interface OCFBaseResponse : RESTResponse
@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, assign) NSInteger code;

@end

