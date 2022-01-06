//
//  OCFPageBaseMenuView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "OCFPageBaseMenuCell.h"
#import "OCFPageBaseMenuCellModel.h"
#import "OCFPageCollectionView.h"

typedef NS_ENUM(NSUInteger, OCFPageMenuViewStyle) {
    OCFPageMenuViewStyleDefault,      // 默认
    OCFPageMenuViewStyleLine,         // 带下划线 (若要选中字体大小不变，设置选中和非选中大小一样即可)
    OCFPageMenuViewStyleTriangle,     // 三角形 (progressHeight 为三角形的高, progressWidths 为底边长)
    OCFPageMenuViewStyleFlood,        // 涌入效果 (填充)
    OCFPageMenuViewStyleFloodHollow,  // 涌入效果 (空心的)
    OCFPageMenuViewStyleSegmented,    // 涌入带边框,即网易新闻选项卡
};

// 原先基础上添加了几个方便布局的枚举，更多布局格式可以通过设置 `itemsMargins` 属性来自定义
// 以下布局均只在 item 个数较少的情况下生效，即无法滚动 MenuView 时.
typedef NS_ENUM(NSUInteger, OCFPageMenuViewLayout) {
    OCFPageMenuViewLayoutScatter, // 默认的布局模式, item 会均匀分布在屏幕上，呈分散状
    OCFPageMenuViewLayoutLeft,    // Item 紧靠屏幕左侧
    OCFPageMenuViewLayoutRight,   // Item 紧靠屏幕右侧
    OCFPageMenuViewLayoutCenter,  // Item 紧挨且居中分布
};

@class OCFPageBaseMenuView;

@protocol OCFPageMenuViewDataSource <NSObject>
@required
- (NSInteger)numbersOfTitlesInMenuView:(OCFPageBaseMenuView *)menu;
- (NSString *)menuView:(OCFPageBaseMenuView *)menu titleAtIndex:(NSInteger)index;

@optional
/**
 *  角标 (例如消息提醒的小红点) 的数据源方法，在 WMPageController 中实现这个方法来为 menuView 提供一个 badgeView
 需要在返回的时候同时设置角标的 frame 属性，该 frame 为相对于 menuItem 的位置
 *
 *  @param index 角标的序号
 *
 *  @return 返回一个设置好 frame 的角标视图
 */
- (UIView *)menuView:(OCFPageBaseMenuView *)menu badgeViewAtIndex:(NSInteger)index;

/**
 *  用于定制 OCFPageMenuItem，可以对传出的 initialMenuItem 进行修改定制，也可以返回自己创建的子类，需要注意的是，此时的 item 的 frame 是不确定的，所以请勿根据此时的 frame 做计算！
 如需根据 frame 修改，请使用代理
 *
 *  @param menu            当前的 menuView，frame 也是不确定的
 *  @param initialMenuItem 初始化完成的 menuItem
 *  @param index           Item 所属的位置;
 *
 *  @return 定制完成的 MenuItem
 */
- (OCFPageBaseMenuCell *)menuView:(OCFPageBaseMenuView *)menu initialMenuItem:(OCFPageBaseMenuCell *)initialMenuItem atIndex:(NSInteger)index;
@end

@protocol OCFPageMenuViewDelegate <NSObject>
@optional
- (void)menuView:(OCFPageBaseMenuView *)menu didClickedRightView:(UIView *)rightView;
- (BOOL)menuView:(OCFPageBaseMenuView *)menu shouldSelesctedIndex:(NSInteger)index;
- (void)menuView:(OCFPageBaseMenuView *)menu didSelectedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;
- (CGFloat)menuView:(OCFPageBaseMenuView *)menu widthForItemAtIndex:(NSInteger)index;
- (CGFloat)menuView:(OCFPageBaseMenuView *)menu itemMarginAtIndex:(NSInteger)index;
- (CGFloat)menuView:(OCFPageBaseMenuView *)menu titleSizeForState:(OCFPageMenuCellState)state atIndex:(NSInteger)index;
- (UIColor *)menuView:(OCFPageBaseMenuView *)menu titleColorForState:(OCFPageMenuCellState)state atIndex:(NSInteger)index;
- (void)menuView:(OCFPageBaseMenuView *)menu didLayoutItemFrame:(OCFPageBaseMenuCell *)menuItem atIndex:(NSInteger)index;

//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选择或者滚动选中都会调用该方法，如果外部不关心具体是点击还是滚动选中的，只关心选中这个事件，就实现该方法。
 
 @param menuView categoryView description
 @param index 选中的index
 */
- (void)menuView:(OCFPageBaseMenuView *)menuView didSelectedItemAtIndex:(NSInteger)index;

/**
 点击选中的情况才会调用该方法
 
 @param menuView categoryView description
 @param index 选中的index
 */
- (void)menuView:(OCFPageBaseMenuView *)menuView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法
 
 @param menuView categoryView description
 @param index 选中的index
 */
- (void)menuView:(OCFPageBaseMenuView *)menuView didScrollSelectedItemAtIndex:(NSInteger)index;


/**
 因为用户点击，contentScrollView即将过渡到目标index的配置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。
 
 @param menuView categoryView description
 @param index index description
 */
- (void)menuView:(OCFPageBaseMenuView *)menuView contentScrollViewTransitionToIndex:(NSInteger)index;

/**
 正在滚动中的回调
 
 @param menuView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 百分比
 */
- (void)menuView:(OCFPageBaseMenuView *)menuView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;
@end


@interface OCFPageBaseMenuView : UIView
@property (nonatomic, assign) BOOL pinToLeft;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) OCFPageCollectionView *collectionView;

@property (nonatomic, strong) NSArray <OCFPageBaseMenuCellModel *>*dataSource;

@property (nonatomic, weak) id<OCFPageMenuViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;    //需要关联的contentScrollView

@property (nonatomic, assign) NSInteger defaultSelectedIndex;   //修改初始化的时候默认选择的index

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat contentEdgeInsetLeft;     //整体内容的左边距，默认kOCFAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat contentEdgeInsetRight;    //整体内容的右边距，默认kOCFAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat cellWidth;    //默认kOCFAutomaticDimension

@property (nonatomic, assign) CGFloat cellWidthIncrement;    //cell宽度补偿。默认：0

@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距，默认20

@property (nonatomic, assign) BOOL averageCellSpacingEnabled;     //当item内容总宽度小于TBPageBaseMenuView的宽度，是否将cellSpacing均分。默认为YES。

//----------------------cellWidthZoomEnabled-----------------------//
//cell宽度的缩放主要是为了腾讯视频效果打造的，一般情况下慎用，不太好控制。
@property (nonatomic, assign) BOOL cellWidthZoomEnabled;     //默认为NO

@property (nonatomic, assign) BOOL cellWidthZoomScrollGradientEnabled;     //手势滚动中，是否需要更新状态。默认为YES

@property (nonatomic, assign) CGFloat cellWidthZoomScale;    //默认1.2，cellWidthZoomEnabled为YES才生效

/**
 代码调用选中了目标index的item
 
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 初始化的时候无需调用。初始化之后更新其他配置属性，需要调用该方法，进行刷新。
 */
- (void)reloadData;

/**
 刷新指定的index的cell
 
 @param index 指定cell的index
 */
- (void)reloadCellAtIndex:(NSInteger)index;

#pragma mark - Subclass use

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

#pragma mark - Subclass Override

- (void)initializeData;

- (void)initializeViews;

/**
 reloadData方法调用，重新生成数据源赋值到self.dataSource
 */
- (void)refreshDataSource;

/**
 reloadData方法调用，根据数据源重新刷新状态；
 */
- (void)refreshState;

- (void)refreshSides;

/**
 用户点击了某个item，刷新选中与取消选中的cellModel
 
 @param selectedCellModel 选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(OCFPageBaseMenuCellModel *)selectedCellModel unselectedCellModel:(OCFPageBaseMenuCellModel *)unselectedCellModel;

/**
 关联的contentScrollView的contentOffset发生了改变
 
 @param contentOffset 偏移量
 */
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset;


/**
 该方法用于子类重载，如果外部要选中某个index，请使用`- (void)selectItemAtIndex:(NSUInteger)index;`
 点击某一个item，或者contentScrollView滚动到某一个item的时候调用。根据selectIndex刷新选中状态。
 
 @param index 选中的index
 @return 返回值为NO，表示触发内部某些判断（点击了同一个cell），子类无需后续操作。
 */
- (BOOL)selectCellAtIndex:(NSInteger)index;

/**
 reloadData时，返回每个cell的宽度
 
 @param index 目标index
 @return cellWidth
 */
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index;


/**
 返回自定义cell的class
 
 @return cell class
 */
- (Class)preferredCellClass;

/**
 refreshState时调用，重置cellModel的状态
 
 @param cellModel 待重置的cellModel
 @param index 目标index
 */
- (void)refreshCellModel:(OCFPageBaseMenuCellModel *)cellModel index:(NSInteger)index;

- (void)rightButtonPressed:(id)sender;

#pragma mark - Page
- (void)resetFrames;
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;
- (void)updateAttributeTitle:(NSAttributedString *)title atIndex:(NSInteger)index andWidth:(BOOL)update;
// - (OCFPageMenuItem *)itemAtIndex:(NSInteger)index;
/// 立即刷新 menuView 的 contentOffset，使 title 居中
- (void)refreshContenOffset;

@end
