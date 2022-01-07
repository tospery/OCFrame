//
//  OCFModel.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import "OCFIdentifiable.h"
#import "OCFStorable.h"
#import <Mantle_JX/Mantle.h>

@interface OCFModel : MTLModel <OCFIdentifiable, OCFStorable, MTLJSONSerializing>

@end
