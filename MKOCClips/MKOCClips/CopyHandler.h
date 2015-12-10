//
//  CopyHandler.h
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CopyHandler : NSObject

- (NSString *)currentPasteBoardContent; // 获取当前剪切板的内容
- (void)copyContentToPasteBoard:(NSString *)content; // 复制内容到剪切板


- (void)saveContent:(NSString *)content; // 保存内容到NSUserDefaults
- (NSMutableArray *)pasteBoardHistory; // 获取保存的内容
- (void)deleteContent:(NSString *)content; // 删除保存的内容
- (NSString *)getTimeInterval:(NSString *)sendDateString; // 获取时间差

@end
