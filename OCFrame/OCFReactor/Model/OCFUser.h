//
//  OCFUser.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import "OCFModel.h"

@interface OCFUser : OCFModel
@property (nonatomic, assign) BOOL isLogined;

- (void)logout;
+ (BOOL)canAutoOpenLoginPage;

@end

