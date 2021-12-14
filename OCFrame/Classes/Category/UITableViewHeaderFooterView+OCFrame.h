//
//  UITableViewHeaderFooterView+OCFrame.h
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (OCFrame)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGFloat)ocf_heightForSection:(NSInteger)section;

@end

