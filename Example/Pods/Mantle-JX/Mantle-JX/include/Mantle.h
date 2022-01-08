//
//  Mantle.h
//  Mantle
//
//  Created by Justin Spahr-Summers on 2012-09-04.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for Mantle.
FOUNDATION_EXPORT double MantleVersionNumber;

//! Project version string for Mantle.
FOUNDATION_EXPORT const unsigned char MantleVersionString[];

#if __has_include(<Mantle_JX/Mantle.h>)
#import <Mantle_JX/MTLJSONAdapter.h>
#import <Mantle_JX/MTLModel.h>
#import <Mantle_JX/MTLModel+NSCoding.h>
#import <Mantle_JX/MTLValueTransformer.h>
#import <Mantle_JX/MTLTransformerErrorHandling.h>
#import <Mantle_JX/NSArray+MTLManipulationAdditions.h>
#import <Mantle_JX/NSDictionary+MTLManipulationAdditions.h>
#import <Mantle_JX/NSDictionary+MTLMappingAdditions.h>
#import <Mantle_JX/NSObject+MTLComparisonAdditions.h>
#import <Mantle_JX/NSValueTransformer+MTLInversionAdditions.h>
#import <Mantle_JX/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#else
#import "MTLJSONAdapter.h"
#import "MTLModel.h"
#import "MTLModel+NSCoding.h"
#import "MTLValueTransformer.h"
#import "MTLTransformerErrorHandling.h"
#import "NSArray+MTLManipulationAdditions.h"
#import "NSDictionary+MTLManipulationAdditions.h"
#import "NSDictionary+MTLMappingAdditions.h"
#import "NSObject+MTLComparisonAdditions.h"
#import "NSValueTransformer+MTLInversionAdditions.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#endif
