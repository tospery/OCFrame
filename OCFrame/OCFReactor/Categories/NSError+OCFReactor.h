//
//  NSError+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <Foundation/Foundation.h>

@interface NSError (OCFReactor)
@property (nonatomic, assign, readonly) BOOL ocf_isNetwork;
@property (nonatomic, assign, readonly) BOOL ocf_isServer;
@property (nonatomic, assign, readonly) BOOL ocf_isCancelled;
@property (nonatomic, strong, readonly) NSString *ocf_titleWhenFailureReasonEmpty;
@property (nonatomic, strong, readonly) NSString *ocf_messageWhenDescriptionEmpty;
@property (nonatomic, strong, readonly) UIImage *ocf_displayImage;

@end

