//
//  OCFPageFactory.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <Foundation/Foundation.h>

#define kOCFAutomaticDimension                   (-1)
#define kOCFUndefinedInteger                     (-32995)
#define kOCFPageViewControllerDidAddToSuperViewNotification          (@"kOCFPageViewControllerDidAddToSuperViewNotification")
#define kOCFPageViewControllerDidFullyDisplayedNotification          (@"kOCFPageViewControllerDidFullyDisplayedNotification")

@interface OCFPageFactory : NSObject
+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;
+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;

@end
