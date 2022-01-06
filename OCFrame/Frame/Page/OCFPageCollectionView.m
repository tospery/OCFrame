//
//  OCFPageCollectionView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/30.
//

#import "OCFPageCollectionView.h"

@interface OCFPageCollectionView ()

@end

@implementation OCFPageCollectionView

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView<OCFPageIndicatorProtocol> *view in self.indicators) {
        [self sendSubviewToBack:view];
    }
}

@end
