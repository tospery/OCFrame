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

#pragma mark - 通知标识
#define kOCFUserWillLoginNotification               (@"kOCFUserWillLoginNotification")
#define kOCFUserDidLoginNotification                (@"kOCFUserDidLoginNotification")
#define kOCFUserWillLogoutNotification              (@"kOCFUserWillLogoutNotification")
#define kOCFUserDidLogoutNotification               (@"kOCFUserDidLogoutNotification")
#define kOCFUserDidExpiredNotification              (@"kOCFUserDidExpiredNotification")
#define kOCFViewControllerWillBackNotification      (@"kOCFViewControllerWillBackNotification")
#define kOCFViewControllerDidBackNotification       (@"kOCFViewControllerDidBackNotification")

#pragma mark - 重用标识
#define kOCFIdentifierTableCell                      (@"kOCFIdentifierTableCell")
#define kOCFIdentifierTableHeaderFooter              (@"kOCFIdentifierTableHeaderFooter")
#define kOCFIdentifierCollectionCell                 (@"kOCFIdentifierCollectionCell")
#define kOCFIdentifierCollectionHeader               (@"kOCFIdentifierCollectionHeader")
#define kOCFIdentifierCollectionFooter               (@"kOCFIdentifierCollectionFooter")

#pragma mark - Scheme
#define kOCFSchemeHTTP                              (@"http")
#define kOCFSchemeAsset                             (@"asset")
#define kOCFSchemeFrame                             (@"frame")
#define kOCFSchemeResource                          (@"resource")
#define kOCFSchemeDocuments                         (@"documents")

#pragma mark - Host
#define kOCFHostAny                                 (@"*")
#define kOCFHostLogin                               (@"login")
#define kOCFHostToast                               (@"toast")
#define kOCFHostAlert                               (@"alert")
#define kOCFHostSheet                               (@"sheet")
#define kOCFHostPopup                               (@"popup")
#define kOCFHostBack                                (@"back")

#pragma mark - Path
#define kOCFPathPop                                 (@"pop")
#define kOCFPathDismiss                             (@"dismiss")
#define kOCFPathFadeaway                            (@"fadeaway")

#pragma mark - Animation
#define kOCFAnimationFade                           (@"fade")
#define kOCFAnimationGrow                           (@"grow")
#define kOCFAnimationShrink                         (@"shrink")
#define kOCFAnimationSlide                          (@"slide")
#define kOCFAnimationBounce                         (@"bounce")

#pragma mark - 便捷
#define kOCFFrameName                               (@"OCFrame")
//#define kOCFVCSuffix                                (@"ViewController")
//#define kOCFVMSuffix                                (@"ViewModel")
#define kOCFBindObjectKey                           (@"kOCFBindObjectKey")

#pragma mark - 日志
#define kOCFLogTagTest                              (@"Test")
#define kOCFLogTagNormal                            (@"Normal")
#define kOCFLogTagLibrary                           (@"Library")
#define kOCFLogTagArgument                          (@"Argument")


#endif /* OCFConstant_h */
