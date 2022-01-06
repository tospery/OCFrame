//
//  OCFConstant.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#ifndef OCFConstant_h
#define OCFConstant_h

#import <Giotto/SDThemeManager.h>

#pragma mark - 布局常量
#define kOCFDimensionMargin         ([(NSNumber *)SDThemeManagerValueForConstant(@"DIMENSION_MARGIN") floatValue])
#define kOCFDimensionPadding        ([(NSNumber *)SDThemeManagerValueForConstant(@"DIMENSION_PADDING") floatValue])


#endif /* OCFConstant_h */
