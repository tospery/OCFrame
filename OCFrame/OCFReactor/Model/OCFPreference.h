//
//  OCFPreference.h
//  OCFrame
//
//  Created by liaoya on 2021/11/15.
//

#import <OCFrame/OCFModel.h>

@interface OCFPreference : OCFModel
@property (nonatomic, assign, readonly) BOOL isCleanInstall;
@property (nonatomic, strong, readonly) NSString *appVersion;

@end

