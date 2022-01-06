//
//  OCFCollectionSupplementaryView.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFCollectionSupplementaryView.h"
#import "UIColor+OCFrame.h"

@interface OCFCollectionSupplementaryView ()
@property (nonatomic, strong, readwrite) OCFBaseReactor *reactor;

@end

@implementation OCFCollectionSupplementaryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.ocf_background;
    }
    return self;
}

- (void)bind:(OCFBaseReactor *)reactor {
    
}

+ (NSString *)kind {
    return UICollectionElementKindSectionHeader;
}

@end
