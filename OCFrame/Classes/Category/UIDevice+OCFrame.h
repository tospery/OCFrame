//
//  UIDevice+OCFrame.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <UIKit/UIKit.h>

@interface UIDevice (OCFrame)
@property (nonatomic, assign, readonly) BOOL ocf_isJailBreaked;
@property (nonatomic, assign, readonly) CGFloat ocf_ppi;
@property (nonatomic, copy, readonly) NSString *ocf_uuid;
@property (nonatomic, copy, readonly) NSString *ocf_idfa;
@property (nonatomic, copy, readonly) NSString *ocf_idfv;
@property (nonatomic, copy, readonly) NSString *ocf_model;

@end

