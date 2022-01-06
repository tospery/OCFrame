//
//  UITableViewHeaderFooterView+OCFReactor.h
//  OCFrame
//
//  Created by liaoya on 2022/1/6.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (OCFReactor)
@property (class, strong, readonly) NSString *ocf_reuseId;

+ (CGFloat)ocf_heightForSection:(NSInteger)section;

@end

