//
//  OCFTableHeaderFooterView.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFTableHeaderFooterView.h"
#import "UIColor+OCFrame.h"

@interface OCFTableHeaderFooterView ()
@property (nonatomic, strong, readwrite) OCFBaseReactor *reactor;

@end

@implementation OCFTableHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.ocf_background;
    }
    return self;
}

- (void)bind:(OCFBaseReactor *)reactor {
    
}

+ (NSString *)kind {
    return nil;
}

@end
