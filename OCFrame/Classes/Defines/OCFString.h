//
//  OCFString.h
//  Pods
//
//  Created by 杨建祥 on 2020/2/23.
//

#ifndef OCFString_h
#define OCFString_h

#define kStringErrorUnknown                                     \
NSLocalizedString(@"Error.Unknown", @"未知错误")
#define kStringErrorRequest                                     \
NSLocalizedString(@"Error.Request", @"HTTP请求错误")
#define kStringErrorRedirect                                    \
NSLocalizedString(@"Error.Redirect", @"HTTP重定向错误")
#define kStringErrorClient                                      \
NSLocalizedString(@"Error.Client", @"HTTP客户端错误")
#define kStringErrorServer                                      \
NSLocalizedString(@"Error.Server", @"HTTP服务器错误")
#define kStringErrorIgnore                                      \
NSLocalizedString(@"Error.Ignore", @"可忽略错误")
#define kStringErrorNetwork                                     \
NSLocalizedString(@"Error.Network", @"网络错误")
#define kStringErrorNavigation                                     \
NSLocalizedString(@"Error.Navigation", @"导航错误")
#define kStringErrorDataFormat                                     \
NSLocalizedString(@"Error.DataFormat", @"数据异常")
#define kStringErrorListIsEmpty                                     \
NSLocalizedString(@"Error.ListIsEmpty", @"列表为空")
#define kStringErrorNotLoginedIn                                     \
NSLocalizedString(@"Error.NotLoginedIn", @"用户未登录")


#import "OCFFunction.h"

// 备份
/********************************************************************************************************
 1个字
 ********************************************************************************************************/
#pragma mark - 1个字
#define kStringNone                                                         \
OCFT(NSLocalizedString(@"None", @"无"), @"无")

/********************************************************************************************************
 2个字
 ********************************************************************************************************/
#pragma mark - 2个字
#define kStringTakePhoto                                                    \
OCFT(NSLocalizedString(@"kStringTakePhoto", @"拍照"), @"拍照")
#define kStringVideoRecord                                                  \
OCFT(NSLocalizedString(@"kStringVideoRecord", @"录像"), @"录像")
#define kStringShoot                                                        \
OCFT(NSLocalizedString(@"kStringShoot", @"摄影"), @"摄影")
#define kStringCapture                                                      \
OCFT(NSLocalizedString(@"kStringCapture", @"拍摄"), @"拍摄")
#define kStringUnknown                                                      \
OCFT(NSLocalizedString(@"kStringUnknown", @"未知"), @"未知")
#define kStringVideo                                                        \
OCFT(NSLocalizedString(@"kStringVideo", @"视频"), @"视频")
#define kStringRefresh                                                      \
OCFT(NSLocalizedString(@"kStringRefresh", @"刷新"), @"刷新")
#define kStringOK                                                           \
OCFT(NSLocalizedString(@"OK", @"确定"), @"确定")
#define kStringCancel                                                       \
OCFT(NSLocalizedString(@"Cancel", @"取消"), @"取消")
#define kStringTips                                                         \
OCFT(NSLocalizedString(@"Tips", @"提示"), @"提示")
#define kStringNumCharsWithEMark                                            \
OCFT(NSLocalizedString(@"chars", @"个字！"), @"个字！")
#define kStringErrorWithGuillemet                                           \
OCFT(NSLocalizedString(@"【Error】", @"【错误】"), @"【错误】")
#define kStringDismiss                                                      \
OCFT(NSLocalizedString(@"Dismiss", @"忽略"), @"忽略")
#define kStringReport                                                       \
OCFT(NSLocalizedString(@"Report", @"报告"), @"报告")
#define kStringExit                                                         \
OCFT(NSLocalizedString(@"Exit", @"退出"), @"退出")
#define kStringSetting                                                      \
OCFT(NSLocalizedString(@"Setting", @"设置"), @"设置")
#define kStringError                                                        \
OCFT(NSLocalizedString(@"Error", @"错误"), @"错误")


/********************************************************************************************************
 3个字
 ********************************************************************************************************/
#pragma mark - 3个字
#define kStringPleaseInput                                                  \
OCFT(NSLocalizedString(@"Please input", @"请输入"), @"请输入")


/********************************************************************************************************
 4个字
 ********************************************************************************************************/
#pragma mark - 4个字
#define kStringReget                                                                    \
OCFT(NSLocalizedString(@"kStringReget", @"重新获取"), @"重新获取")
#define kStringReload                                                                   \
OCFT(NSLocalizedString(@"kStringReload", @"重新加载"), @"重新加载")
#define kStringToBeContinued                                                            \
OCFT(NSLocalizedString(@"kStringToBeContinued", @"未完待续"), @"未完待续")
#define kStringReLogin                                                                  \
OCFT(NSLocalizedString(@"kStringReLogin", @"重新登录"), @"重新登录")
#define kStringRefreshNow                                                               \
OCFT(NSLocalizedString(@"kStringRefreshNow", @"立即刷新"), @"立即刷新")
#define kStringParameterExceptionWithEMark                                              \
OCFT(NSLocalizedString(@"Parameter exception!", @"参数异常！"), @"参数异常！")
#define kStringSoSorry                                                                  \
OCFT(NSLocalizedString(@"So sorry", @"非常抱歉"), @"非常抱歉")
#define kStringExceptionReport                                                          \
OCFT(NSLocalizedString(@"Exception report", @"异常报告"), @"异常报告")
#define kStringHandling                                                                 \
OCFT(NSLocalizedString(@"Handling ", @"正在处理"), @"正在处理")
#define kStringSigninFailure                                                            \
OCFT(NSLocalizedString(@"kStringSigninFailure", @"注册失败"), @"注册失败")
#define kStringLocateFailure                                                            \
OCFT(NSLocalizedString(@"kStringLocateFailure", @"定位失败"), @"定位失败")
#define kStringArgumentError                                                            \
OCFT(NSLocalizedString(@"kStringArgumentError", @"参数错误"), @"参数错误")
#define kStringExecuteFailure                                                           \
OCFT(NSLocalizedString(@"kStringExecuteFailure", @"执行失败"), @"执行失败")
#define kStringActionFailure                                                            \
OCFT(NSLocalizedString(@"kStringActionFailure", @"操作失败"), @"操作失败")
#define kStringParseFailure                                                            \
OCFT(NSLocalizedString(@"kStringParseFailure", @"解析失败"), @"解析失败")
#define kStringEnvDev                                                        \
OCFT(NSLocalizedString(@"kStringEnvDev", @"开发环境"), @"开发环境")
#define kStringEnvHoc                                                        \
OCFT(NSLocalizedString(@"kStringEnvHoc", @"测试环境"), @"测试环境")
#define kStringEnvApp                                                        \
OCFT(NSLocalizedString(@"kStringEnvApp", @"正式环境"), @"正式环境")


/********************************************************************************************************
 5个字
 ********************************************************************************************************/
#pragma mark - 5个字
#define kStringGetCode                                                                      \
OCFT(NSLocalizedString(@"kStringGetCode", @"获取验证码"), @"获取验证码")
#define kStringChooseInvalidFile                                                            \
OCFT(NSLocalizedString(@"kStringChooseInvalidFile", @"无效的文件"), @"无效的文件")
#define kStringDataInvalid                                                                  \
OCFT(NSLocalizedString(@"kStringDataInvalid", @"无效的数据"), @"无效的数据")
#define kStringPleaseInputAtLeast                                                           \
OCFT(NSLocalizedString(@"PleaseInput", @"请输入至少"), @"请输入至少")
#define kStringUnhandledError                                                               \
OCFT(NSLocalizedString(@"Unhandled error", @"未处理错误"), @"未处理错误")
#define kStringPasswordNotSame                                                              \
OCFT(NSLocalizedString(@"kStringPasswordNotSame", @"密码不一致"), @"密码不一致")
#define kStringInvalidArgument                                                              \
OCFT(NSLocalizedString(@"kStringInvalidArgument", @"无效的参数"), @"无效的参数")


/********************************************************************************************************
 超过5个字
 ********************************************************************************************************/
#pragma mark - 超过5个字
#define kStringChooseFromAlbum                                                                          \
OCFT(NSLocalizedString(@"kStringChooseFromAlbum", @"从相册中选取"), @"从相册中选取")
#define kStringChooseFromLibrary                                                                          \
OCFT(NSLocalizedString(@"kStringChooseFromLibrary", @"从媒体库中选取"), @"从媒体库中选取")

#define kStringTokenInvalid                                                                           \
OCFT(NSLocalizedString(@"kStringTokenInvalid", @"登录已过期，请重新登录"), @"登录已过期，请重新登录")
#define kStringComingSoon                                                                           \
OCFT(NSLocalizedString(@"kStringComingSoon", @"暂未开放，敬请期待"), @"暂未开放，敬请期待")
#define kStringLocatingFailedOpenWifi                                                                           \
OCFT(NSLocalizedString(@"kStringLocatingFailedOpenWifi", @"定位失败，打开WiFi会提高定位的精确度"), @"定位失败，打开WiFi会提高定位的精确度")
#define kStringHTTPRequestError                                                         \
OCFT(NSLocalizedString(@"kStringHTTPRequestError", @"HTTP请求错误"), @"HTTP请求错误")
#define kStringHTTPRedirectError                                                        \
OCFT(NSLocalizedString(@"kStringHTTPRedirectError", @"HTTP重定向错误"), @"HTTP重定向错误")
#define kStringHTTPClientError                                                          \
OCFT(NSLocalizedString(@"kStringHTTPClientError", @"HTTP客户端错误"), @"HTTP客户端错误")
#define kStringHTTPServerError                                                          \
OCFT(NSLocalizedString(@"kStringHTTPServerError", @"HTTP服务器错误"), @"HTTP服务器错误")
#define kStringNetworkException                                                         \
OCFT(NSLocalizedString(@"kStringNetworkException", @"貌似没有网络，请检查网络"), @"貌似没有网络，请检查网络")
#define kStringServerException                                                          \
OCFT(NSLocalizedString(@"kStringServerException", @"服务不给力，请稍后重试"), @"服务不给力，请稍后重试")
#define kStringDataEmpty                                                                \
OCFT(NSLocalizedString(@"kStringDataEmpty", @"没有符合条件的数据"), @"没有符合条件的数据")
#define kStringLoginUnfinished                                                          \
OCFT(NSLocalizedString(@"kStringLoginUnfinished", @"亲，您还没有登录~"), @"亲，您还没有登录~")
#define kStringLoginExpired                                                             \
OCFT(NSLocalizedString(@"kStringLoginExpired", @"您长时间没有使用、请重新登录~"), @"您长时间没有使用、请重新登录~")
#define kStringLoginHasnotAccount                                                       \
OCFT(NSLocalizedString(@"kStringLoginHasnotAccount", @"账号不存在，请检查确认"), @"账号不存在，请检查确认")
#define kStringLoginWrongPassword                                                       \
OCFT(NSLocalizedString(@"kStringLoginWrongPassword", @"密码错误，请重新输入"), @"密码错误，请重新输入")
#define kStringLoginNotPermission                                                       \
OCFT(NSLocalizedString(@"kStringLoginNotPermission", @"您没有登录权限，请联系管理员"), @"您没有登录权限，请联系管理员")
#define kStringLocateClosed                                                             \
OCFT(NSLocalizedString(@"kStringLocateClosed", @"定位未开启，请前往设置页面打开"), @"定位未开启，请前往设置页面打开")
#define kStringLocateDenied                                                             \
OCFT(NSLocalizedString(@"kStringLocateDenied", @"定位未允许，请前往设置页面确认"), @"定位未允许，请前往设置页面确认")
#define kStringDeviceNotSupport                    \
OCFT(NSLocalizedString(@"kStringDeviceNotSupport", @"您的设备不支持该功能"), @"您的设备不支持该功能")
#define kStringFileNotPicture                                                      \
OCFT(NSLocalizedString(@"kStringFileNotPicture", @"所选文件不是一张图片，请重新选择"), @"所选文件不是一张图片，请重新选择")
#define kStringCheckUpdateFailure                                                         \
OCFT(NSLocalizedString(@"kStringCheckUpdateFailure", @"检查更新失败"), @"检查更新失败")
#define kStringiPhone                                                                   \
OCFT(NSLocalizedString(@"iPhone", @"iPhone"), @"iPhone")
#define kStringExceptionExitAtPreviousRuningWithEMark                                                               \
OCFT(NSLocalizedString(@"An error occurred on the previous run", @"程序在上次异常退出！"), @"程序在上次异常退出！")
#define kStringLoadFailedWithCommaClickToRetryWithExclam                                                            \
OCFT(NSLocalizedString(@"Load failed, click to retry!", @"加载失败，点击重试！"), @"加载失败，点击重试！")
#define kStringYourDeviceNotSupportCallFunction                                                                     \
OCFT(NSLocalizedString(@"kStringYourDeviceNotSupportCallFunction", @"您的设备不支持电话功能"), @"您的设备不支持电话功能")
#define kStringYourDeviceNotSupportMessageFunction                                                                     \
OCFT(NSLocalizedString(@"kStringYourDeviceNotSupportMessageFunction", @"您的设备不支持短信功能"), @"您的设备不支持短信功能")
#define kStringNotSupportThisDevice                                                                       \
OCFT(NSLocalizedString(@"kStringNotSupportThisDevice", @"不支持该设备"), @"不支持该设备")
#define kStringPleaseInputPhoneNumber                                                                               \
OCFT(NSLocalizedString(@"PleaseInputPhoneNumber", @"请输入手机号码"), @"请输入手机号码")
#define kStringPleaseInputValidPhone                                                                               \
OCFT(NSLocalizedString(@"kStringPleaseInputValidPhone", @"请输入有效的手机号"), @"请输入有效的手机号")
#define kStringPleaseInputValidEmail                                                                               \
OCFT(NSLocalizedString(@"kStringPleaseInputValidEmail", @"请输入有效的邮箱"), @"请输入有效的邮箱")
#define kStringPhoneNumberCantAllWhitespace                    \
OCFT(NSLocalizedString(@"kStringPhoneNumberCantAllWhitespace", @"手机号码不能全为空格"), @"手机号码不能全为空格")
#define kStringPhoneNumberNeedNotSame                                                                                   \
OCFT(NSLocalizedString(@"PhoneNumberNeedNotSame", @"请输入与原手机号码不一样的号码"), @"请输入与原手机号码不一样的号码")
#define kStringEmailNeedNotSame                                                                                   \
OCFT(NSLocalizedString(@"kStringEmailNeedNotSame", @"请输入与原邮箱不一样的邮箱"), @"请输入与原邮箱不一样的邮箱")
#define kStringPhoneNumberMustBe11Count                                                                     \
OCFT(NSLocalizedString(@"PhoneNumberMustBe11Count", @"手机号码必须是11位"), @"手机号码必须是11位")
#define kStringPhoneNumberFormatError          \
OCFT(NSLocalizedString(@"PhoneNumberFormatError", @"手机号码格式错误"), @"手机号码格式错误")
#define kStringPhoneNumberInvalidChar          \
OCFT(NSLocalizedString(@"kStringPhoneNumberInvalidChar", @"手机号码不能包含无效字符"), @"手机号码不能包含无效字符")

#define kStringUnhandledCase                    \
OCFT(NSLocalizedString(@"UnhandledCase", @"未处理的case！"), @"未处理的case！")
#define kStringCantAllWhitespace                    \
OCFT(NSLocalizedString(@"kStringCantAllWhitespace", @"不能全为空格或换行"), @"不能全为空格或换行")
#define kStringCantLTWhitespace                    \
OCFT(NSLocalizedString(@"kStringCantLTWhitespace", @"首尾不能包含空格或换行"), @"首尾不能包含空格或换行")
#define kStringMustASCIIChars                    \
OCFT(NSLocalizedString(@"kStringMustASCIIChars", @"只能为字母或数字"), @"只能为字母或数字")
#define kStringLocationServiceIsClosedPleaseToOpenInSetting                    \
OCFT(NSLocalizedString(@"kStringLocationServiceIsClosedPleaseToOpenInSetting", @"定位服务已关闭，请前往设置页打开"), @"定位服务已关闭，请前往设置页打开")
#define kStringLocationServiceIsRejectedPleaseToOpenInSetting                    \
OCFT(NSLocalizedString(@"kStringLocationServiceIsRejectedPleaseToOpenInSetting", @"定位服务已拒绝，请前往设置页打开"), @"定位服务已拒绝，请前往设置页打开")
#define kStringBackToSeeEffect                    \
OCFT(NSLocalizedString(@"kStringBackToSeeEffect", @"直接返回查看效果"), @"直接返回查看效果")

/********************************************************************************************************
错误
********************************************************************************************************/
#define kStringErrorEmpty                               \
OCFT(NSLocalizedString(@"kStringErrorEmpty", @"HTTP数据为空"), @"HTTP数据为空")
#define kStringErrorData                                \
OCFT(NSLocalizedString(@"kStringErrorData", @"HTTP数据异常"), @"HTTP数据异常")
#define kStringErrorExpired                             \
OCFT(NSLocalizedString(@"kStringErrorExpired", @"登录过期"), @"登录过期")

#endif /* OCFString_h */
