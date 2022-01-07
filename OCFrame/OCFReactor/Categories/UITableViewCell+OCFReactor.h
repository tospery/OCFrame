//
//  UITableViewCell+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/7.
//

#import <UIKit/UIKit.h>
#import "OCFTableItem.h"

@interface UITableViewCell (OCFReactor)

+ (CGFloat)ocf_heightWithItem:(OCFTableItem *)item;

@end
