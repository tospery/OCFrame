//
//  OCFUser.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFBaseModel.h"

@interface OCFUser : OCFBaseModel
@property (nonatomic, assign) BOOL isLogined;

- (void)logout;
+ (BOOL)canAutoOpenLoginPage;

@end

