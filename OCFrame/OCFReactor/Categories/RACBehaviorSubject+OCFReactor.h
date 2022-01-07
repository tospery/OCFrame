//
//  RACBehaviorSubject+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <ReactiveObjC/ReactiveObjC.h>

@interface RACBehaviorSubject (OCFReactor)
@property (nonatomic, strong, readonly) id value;

@end
