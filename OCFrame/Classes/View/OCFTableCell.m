//
//  OCFTableCell.m
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import "OCFTableCell.h"
#import "OCFFunction.h"
#import "UIColor+OCFrame.h"

@interface OCFTableCell ()
@property (nonatomic, strong, readwrite) OCFTableItem *reactor;

@end

@implementation OCFTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.ocf_background;
    }
    return self;
}

- (void)bind:(OCFTableItem *)reactor {
    self.reactor = reactor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
