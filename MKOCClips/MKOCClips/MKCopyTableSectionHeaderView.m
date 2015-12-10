//
//  MKCopyTableSectionHeaderView.m
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import "MKCopyTableSectionHeaderView.h"

@implementation MKCopyTableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat leftSpace = 16.0;
        CGFloat width = frame.size.width - leftSpace * 2;
        CGFloat height = frame.size.height;
        self.displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, width, height)];
        self.displayLabel.font = [UIFont systemFontOfSize:15.0];
        self.displayLabel.textColor = [UIColor grayColor];
        [self addSubview:self.displayLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
