//
//  OCFPageCollectionView.h
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import <UIKit/UIKit.h>
#import "OCFPageIndicatorProtocol.h"

@interface OCFPageCollectionView : UICollectionView
@property (nonatomic, strong) NSArray<UIView<OCFPageIndicatorProtocol> *> *indicators;

@end
