//
//  OCFIdentifiable.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import <UIKit/UIKit.h>

@protocol OCFIdentifiable <NSObject>
@property (nonatomic, strong, readonly) NSString *id;

- (instancetype)initWithID:(NSString *)id;

@end

