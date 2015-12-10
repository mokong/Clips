//
//  MKCopyTableViewCell.h
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKCopyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *displayLabel; // 内容
@property (weak, nonatomic) IBOutlet UILabel *timeIntervalLabel; // 时间
@property (weak, nonatomic) IBOutlet UILabel *sourceDisplayLabel; // 来源

@end
