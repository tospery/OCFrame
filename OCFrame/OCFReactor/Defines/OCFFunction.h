//
//  OCFFunction.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#ifndef OCFFunction_h
#define OCFFunction_h

#import <QMUIKit/QMUIKit.h>
#import "OCFType.h"
#import "NSObject+OCFrame.h"

#define IS_SMALL_SCREEN         (DEVICE_WIDTH <= 320)
#define IS_MIDDLE_SCREEN        (DEVICE_WIDTH > 320 && DEVICE_WIDTH < 414)
#define IS_LARGE_SCREEN         (DEVICE_WIDTH >= 414)

#pragma mark - 本地化
#ifdef OCFEnableFuncLocalize
#define OCFT(local, display)                 (local)
#else
#define OCFT(local, display)                 (display)
#endif


#pragma mark - 尺寸
CG_INLINE CGFloat
OCFMetric(CGFloat value) {
    return flat(value / 375.f * DEVICE_WIDTH);
}

CG_INLINE CGFloat
OCFPrefer(CGFloat small, CGFloat middle, CGFloat large) {
    return flat(IS_SMALL_SCREEN ? small : (IS_MIDDLE_SCREEN ? middle : large));
}

CG_INLINE CGFloat
OCFScale(CGFloat value) {
    return flat(value * DEVICE_WIDTH);
}

#endif /* OCFFunction_h */
