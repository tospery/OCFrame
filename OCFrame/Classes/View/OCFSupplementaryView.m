//
//  OCFSupplementaryView.m
//  Pods
//
//  Created by 杨建祥 on 2020/2/22.
//

#import "OCFSupplementaryView.h"

@interface OCFSupplementaryView ()
@property (nonatomic, strong, readwrite) OCFBaseReactor *reactor;

@end

@implementation OCFSupplementaryView

- (void)bind:(OCFBaseReactor *)reactor {
    
}

+ (NSString *)kind {
    return UICollectionElementKindSectionHeader;
}

@end
