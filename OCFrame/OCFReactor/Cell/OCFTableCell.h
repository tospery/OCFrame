//
//  OCFTableCell.h
//  OCFrame
//
//  Created by liaoya on 2021/12/14.
//

#import <UIKit/UIKit.h>
#import "OCFReactive.h"
#import "OCFTableItem.h"

@interface OCFTableCell : UITableViewCell <OCFReactive>
@property (nonatomic, strong, readonly) OCFTableItem *reactor;

@end

