//
//  OCFIdentifiable.h
//  OCFrame
//
//  Created by 杨建祥 on 2022/1/3.
//

#import <Foundation/Foundation.h>

@protocol OCFIdentifiable <NSObject>
@required
@property (nonatomic, strong, readonly) NSString *id;
- (instancetype)initWithID:(NSString *)id;

@end

