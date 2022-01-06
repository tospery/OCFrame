//
//  UITableViewCell+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "OCFTableItem.h"

@interface UITableViewCell (OCFReactor)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGFloat)ocf_heightWithItem:(OCFTableItem *)item;

@end

