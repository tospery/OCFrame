//
//  OCFPreference.h
//  OCFrame
//
//  Created by liaoya on 2021/11/15.
//

#import <OCFrame/OCFrame.h>

@interface OCFPreference : OCFBaseModel
@property (nonatomic, assign, readonly) BOOL isCleanInstall;
@property (nonatomic, strong, readonly) NSString *appVersion;

@end

