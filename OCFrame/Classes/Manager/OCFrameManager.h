//
//  OCFrameManager.h
//  OCFrame
//
//  Created by 杨建祥 on 2020/2/28.
//

#import <UIKit/UIKit.h>
#import "OCFPage.h"

@interface OCFrameManager : NSObject
@property (nonatomic, assign) CGFloat autoLogin;
@property (nonatomic, assign) CGFloat fontScale;
@property (nonatomic, strong) NSString *loginPattern;
@property (nonatomic, strong) NSString *baseURLString;
@property (nonatomic, strong) NSString *appScheme;
@property (nonatomic, strong) OCFPage *page;


+ (instancetype)sharedInstance;

@end
