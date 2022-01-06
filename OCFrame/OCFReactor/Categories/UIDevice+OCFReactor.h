//
//  UIDevice+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

@interface UIDevice (OCFReactor)
@property (nonatomic, assign, readonly) BOOL ocf_isJailBreaked;
//@property (nonatomic, assign, readonly) CGFloat ocf_ppi;
@property (nonatomic, copy, readonly) NSString *ocf_uuid;
@property (nonatomic, copy, readonly) NSString *ocf_idfa;
@property (nonatomic, copy, readonly) NSString *ocf_idfv;
//@property (nonatomic, copy, readonly) NSString *ocf_model;

@end

