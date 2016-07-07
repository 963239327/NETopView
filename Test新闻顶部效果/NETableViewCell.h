//
//  NETableViewCell.h
//  Test新闻顶部效果
//
//  Created by iCodeWoods on 16/7/7.
//  Copyright © 2016年 iCodeWoods. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const ideNETableViewCellReuseId = @"ideNETableViewCellReuseId";

@class NEModel;
@interface NETableViewCell : UITableViewCell

@property (nonatomic, strong) NEModel *model;

@end
