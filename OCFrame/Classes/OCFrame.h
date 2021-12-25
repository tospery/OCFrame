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
#import "OCFMetric.h"
#import "OCFBaseModel.h"
#import "OCFProvider.h"
#import "OCFNavigator.h"
#import "OCFAppDependency.h"
#import "OCFParameter.h"
#import "OCFUser.h"
#import "OCFMisc.h"
#import "OCFBaseResponse.h"
#import "OCFBaseList.h"
#import "OCFPage.h"
#import "OCFNormalCollectionModel.h"
#import "OCFConfiguration.h"
#import "OCFPreference.h"
#import "OCFSimpleAlertAction.h"
#import "OCFReachManager.h"
#import "OCFNormalTableModel.h"
#import "OCFPlainModel.h"
#import "OCFBehaviorRelay.h"
#import "OCFEmptyReactor.h"

#pragma mark - View
#import "OCFReactiveView.h"
#import "OCFCollectionSupplementaryView.h"
#import "OCFCollectionCell.h"
#import "OCFNavigationBar.h"
#import "OCFPopupBackgroundView.h"
#import "OCFWebProgressView.h"
#import "OCFNormalCollectionCell.h"
#import "OCFBorderLayer.h"
#import "OCFTableCell.h"
#import "OCFNormalTableCell.h"
#import "OCFTableHeaderFooterView.h"
#import "OCFEmptyView.h"

#pragma mark - Controller
#import "OCFViewController.h"
#import "OCFScrollViewController.h"
#import "OCFCollectionViewController.h"
#import "OCFTabBarViewController.h"
#import "OCFNavigationController.h"
#import "OCFWebViewController.h"
#import "OCFLoginViewController.h"
#import "OCFTabBarController.h"
#import "OCFTableViewController.h"

#pragma mark - Reactor
#import "OCFBaseReactor.h"
#import "OCFViewReactor.h"
#import "OCFScrollViewReactor.h"
#import "OCFCollectionViewReactor.h"
#import "OCFTabBarViewReactor.h"
#import "OCFWebViewReactor.h"
#import "OCFLoginViewReactor.h"
#import "OCFScrollItem.h"
#import "OCFCollectionItem.h"
#import "OCFNormalCollectionItem.h"
#import "OCFTabBarReactor.h"
#import "OCFTableViewReactor.h"
#import "OCFTableItem.h"
#import "OCFNormalTableItem.h"

#pragma mark - Protocol
#import "OCFReactive.h"
#import "OCFNavigable.h"
#import "OCFIdentifiable.h"
#import "OCFCollectionSupplementary.h"
#import "OCFTableHeaderFooter.h"

#pragma mark - Protocol
#import "OCFAppearanceManager.h"
#import "OCFBaseSessionManager.h"
#import "OCFLibraryManager.h"
#import "OCFrameManager.h"
#import "OCFRouterManager.h"
#import "OCFRuntimeManager.h"

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
#import "UICollectionView+OCFrame.h"
#import "UIImageView+OCFrame.h"
#import "UINavigationController+OCFrame.h"
#import "UILabel+OCFrame.h"
#import "UITableViewCell+OCFrame.h"
#import "UITableViewHeaderFooterView+OCFrame.h"
#import "UITableView+OCFrame.h"

#pragma mark - Bridge
#import "WKWebViewJavascriptBridge.h"

#pragma mark - Vendor
#import <AFNetworking/AFNetworking.h>
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
#import <Giotto/SDThemeManager.h>
