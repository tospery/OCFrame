//
//  OCFrame.h
//  OCFrame
//
//  Created by 杨建祥 on 2020/2/28.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#pragma mark - Defines
#import "OCFType.h"
#import "OCFConstant.h"
#import "OCFFunction.h"
#import "OCFString.h"

#pragma mark - Model
#import "OCFBaseModel.h"
#import "OCFProvider.h"
#import "OCFNavigator.h"
#import "OCFAppDependency.h"
#import "OCFParameter.h"
#import "OCFrameManager.h"
#import "OCFUser.h"
#import "OCFMisc.h"
#import "OCFBaseResponse.h"
#import "OCFBaseList.h"
#import "OCFBaseSessionManager.h"
#import "OCFPage.h"
#import "OCFNormalCollectionModel.h"
//#import "OCFObject.h"
//#import "OCFFrameManager.h"
//#import "OCFPageFactory.h"
//#import "OCFPageMenuIndicatorModel.h"
//#import "OCFPageMenuAnimator.h"
//#import "OCFBaseCommand.h"
//#import "OCFBaseList.h"
//#import "OCFNormalModel.h"

#pragma mark - Reactor
#import "OCFBaseReactor.h"
#import "OCFViewReactor.h"
#import "OCFScrollViewReactor.h"
#import "OCFCollectionViewReactor.h"
#import "OCFTabBarViewReactor.h"
#import "OCFWebViewReactor.h"
#import "OCFLoginViewReactor.h"
#import "OCFCellReactor.h"
#import "OCFCollectionReactor.h"
#import "OCFNormalCollectionReactor.h"
//#import "OCFPageViewModel.h"
//#import "OCFCellReactor.h"
//#import "OCFTableItem.h"
//#import "OCFCollectionReactor.h"
//#import "OCFPageMenuItem.h"
//#import "OCFPageMenuIndicatorItem.h"
//#import "OCFPageMenuTitleItem.h"
//#import "OCFPage.h"
//#import "OCFParameter.h"
//#import "OCFBaseResponse.h"
//#import "OCFBaseSessionManager.h"
//#import "OCFWaterfallViewModel.h"
//#import "OCFNormalCollectionItem.h"

#pragma mark - Controller
#import "OCFViewController.h"
#import "OCFScrollViewController.h"
#import "OCFCollectionViewController.h"
#import "OCFTabBarViewController.h"
#import "OCFNavigationController.h"
#import "OCFWebViewController.h"
#import "OCFLoginViewController.h"
//#import "OCFPageViewController.h"
//#import "OCFWaterfallViewController.h"

#pragma mark - View
#import "OCFReactiveView.h"
#import "OCFSupplementaryView.h"
#import "OCFCollectionCell.h"
#import "OCFNavigationBar.h"
#import "OCFPopupBackgroundView.h"
#import "OCFWebProgressView.h"
#import "OCFNormalCollectionCell.h"
#import "OCFBorderLayer.h"
#import "OCFLabel.h"
#import "OCFButton.h"
//#import "OCFTableCell.h"
//#import "OCFBaseSupplementaryView.h"
//#import "OCFWebProgressView.h"
//#import "OCFPageMenuCollectionView.h"
//#import "OCFPageContainerView.h"
//#import "OCFPageMenuIndicatorCell.h"
//#import "OCFPageMenuIndicatorView.h"
//#import "OCFPageMenuIndicatorComponentView.h"
//#import "OCFPageMenuIndicatorBackgroundView.h"
//#import "OCFPageMenuIndicatorLineView.h"
//#import "OCFPageMenuTitleCell.h"
//#import "OCFPageMenuTitleView.h"
//#import "OCFLabel.h"
//#import "OCFButton.h"
//#import "OCFNormalCollectionCell.h"
//#import "OCFBorderLayer.h"

#pragma mark - Category
#import "NSObject+OCFrame.h"
#import "NSString+OCFrame.h"
#import "NSNumber+OCFrame.h"
#import "NSURL+OCFrame.h"
#import "NSError+OCFrame.h"
#import "NSBundle+OCFrame.h"
#import "NSArray+OCFrame.h"
#import "NSDictionary+OCFrame.h"
#import "NSAttributedString+OCFrame.h"
#import "NSValueTransformer+OCFrame.h"
#import "UIView+OCFrame.h"
#import "UIColor+OCFrame.h"
#import "UIFont+OCFrame.h"
#import "UIImage+OCFrame.h"
#import "UIDevice+OCFrame.h"
#import "UIScrollView+OCFrame.h"
#import "UIViewController+OCFrame.h"
#import "UIApplication+OCFrame.h"
#import "UICollectionReusableView+OCFrame.h"
#import "MTLModel+OCFrame.h"
#import "MTLJSONAdapter+OCFrame.h"

//#import "NSString+OCFrame.h"
//#import "NSNumber+OCFrame.h"
//#import "NSArray+OCFrame.h"
//#import "NSDictionary+OCFrame.h"
//#import "NSURL+OCFrame.h"
//#import "NSAttributedString+OCFrame.h"
//#import "NSBundle+OCFrame.h"
//#import "NSValueTransformer+OCFrame.h"
//#import "UINavigationBar+OCFrame.h"
//#import "UIColor+OCFrame.h"
//#import "UIDevice+OCFrame.h"
//#import "UIViewController+OCFrame.h"
//#import "UICollectionReusableView+OCFrame.h"

#pragma mark - Protocol
#import "OCFReactive.h"
#import "OCFNavigable.h"
#import "OCFIdentifiable.h"
#import "OCFSupplementary.h"
//#import "OCFSupplementaryView.h"
//#import "OCFNavigationProtocol.h"
//#import "OCFProvisionProtocol.h"
//#import "OCFPageMenuIndicator.h"
//#import "OCFPageContainerProtocol.h"
//#import "OCFPageContentProtocol.h"

#pragma mark - Vendor
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import <Mantle/Mantle.h>
#import <RESTful/RESTful.h>
#import <PINCache/PINCache.h>
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteHandler.h>
#import <JLRoutes/JLRRouteDefinition.h>
#import <QMUIKit/QMUIKit.h>
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <UICKeyChainStore/UICKeyChainStore.h>
#import <FCUUID/FCUUID.h>
#import <SDWebImage/SDWebImage.h>
#import <Toast/UIView+Toast.h>
#import <TYAlertController/TYAlertController.h>
#import <DKNightVersion/DKNightVersion.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
