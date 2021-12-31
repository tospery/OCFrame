//
//  OCFBaseResponse.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#import <Overcoat_JX/Overcoat.h>

@interface OCFBaseResponse : OVCResponse
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong, readonly) NSString *message;

//- (NSInteger)mappedCode;
//- (NSString *)mappedMessage;

@end

