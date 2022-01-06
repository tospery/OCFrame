//
//  OCFModel.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "OCFIdentifiable.h"
#import "OCFStorable.h"
#import "MTLJSONAdapter+OCFModel.h"
#import "NSValueTransformer+OCFModel.h"
#import <Mantle_JX/Mantle.h>
#import <PINCache/PINCache.h>

@interface OCFModel : MTLModel <OCFIdentifiable, OCFStorable, MTLJSONSerializing>
@property (nonatomic, assign, readonly) BOOL isValid;

@end
