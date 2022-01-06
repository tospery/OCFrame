//
//  UITableViewCell+OCFrame.h
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import <UIKit/UIKit.h>
#import "OCFTableItem.h"

@interface UITableViewCell (OCFrame)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGFloat)ocf_heightWithItem:(OCFTableItem *)item;

@end

