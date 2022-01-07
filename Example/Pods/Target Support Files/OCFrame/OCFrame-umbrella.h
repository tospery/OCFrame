#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MTLJSONAdapter+OCFCore.h"
#import "NSBundle+OCFCore.h"
#import "NSError+OCFCore.h"
#import "NSObject+OCFCore.h"
#import "NSValueTransformer+OCFCore.h"
#import "OCFCore.h"
#import "OCFDefines.h"
#import "OCFFunctions.h"
#import "OCFIdentifiable.h"
#import "OCFModel.h"
#import "OCFStorable.h"
#import "OCFStrings.h"
#import "DDLog+OCFExtensions.h"
#import "MTLJSONAdapter+OCFExtensions.h"
#import "MTLModel+OCFExtensions.h"
#import "NSArray+OCFExtensions.h"
#import "NSAttributedString+OCFExtensions.h"
#import "NSBundle+OCFExtensions.h"
#import "NSDictionary+OCFExtensions.h"
#import "NSError+OCFExtensions.h"
#import "NSMutableAttributedString+OCFExtensions.h"
#import "NSObject+OCFExtensions.h"
#import "NSString+OCFExtensions.h"
#import "NSURL+OCFExtensions.h"
#import "NSValueTransformer+OCFExtensions.h"
#import "OCFBorderLayer.h"
#import "OCFExtensions.h"
#import "OCFHelper.h"
#import "RACBehaviorSubject+OCFExtensions.h"
#import "UIApplication+OCFExtensions.h"
#import "UICollectionReusableView+OCFExtensions.h"
#import "UICollectionView+OCFExtensions.h"
#import "UIColor+OCFExtensions.h"
#import "UIDevice+OCFExtensions.h"
#import "UIFont+OCFExtensions.h"
#import "UIImage+OCFExtensions.h"
#import "UIImageView+OCFExtensions.h"
#import "UILabel+OCFExtensions.h"
#import "UINavigationController+OCFExtensions.h"
#import "UIScreen+OCFExtensions.h"
#import "UIScrollView+OCFExtensions.h"
#import "UITableView+OCFExtensions.h"
#import "UITableViewCell+OCFExtensions.h"
#import "UITableViewHeaderFooterView+OCFExtensions.h"
#import "UIView+OCFExtensions.h"
#import "UIViewController+OCFExtensions.h"

FOUNDATION_EXPORT double OCFrameVersionNumber;
FOUNDATION_EXPORT const unsigned char OCFrameVersionString[];

