//
//  OCFRouterManager.h
//  OCFrame-OCFrame
//
//  Created by liaoya on 2021/10/25.
//

#import <Foundation/Foundation.h>
#import "OCFProvider.h"
#import "OCFNavigator.h"

@interface OCFRouterManager : NSObject

- (void)setupWithProvider:(OCFProvider *)provider navigator:(OCFNavigator *)navigator;

+ (instancetype)sharedInstance;

@end
