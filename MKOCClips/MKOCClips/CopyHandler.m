//
//  CopyHandler.m
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import "CopyHandler.h"
#import "MKCopyItem.h"

@interface CopyHandler ()

@property (nonatomic, strong) UIPasteboard *pasteBoard;
@property (nonatomic, strong) NSUserDefaults *sharedUserDefault;

@end

@implementation CopyHandler

- (void)setupPasteBoard {
    if (self.pasteBoard) {
        return;
    }
    self.pasteBoard = [UIPasteboard generalPasteboard];
}

- (void)setupSharedUserDefault {
    if (self.sharedUserDefault) {
        return;
    }
    self.sharedUserDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.wiwide.OCCopyExtension"];
}

- (void)copyContentToPasteBoard:(NSString *)content {
    [self setupPasteBoard];
    self.pasteBoard.string = content;
}

- (NSString *)currentPasteBoardContent {
    [self setupPasteBoard];
    return self.pasteBoard.string;
}

- (void)saveContent:(NSString *)content {
    if (content == nil || content.length == 0) {
        return;
    }
    [self setupSharedUserDefault];
    NSDate *currentDate = [NSDate date];
    NSString *saveDate = [self stringFromDate:currentDate];
    NSString *currentSource = [UIDevice currentDevice].name;
    MKCopyItem *tempItem = [[MKCopyItem alloc] initWithContent:content date:saveDate status:@1 pasteBoardSource:currentSource];
    NSData *tempData = [self.sharedUserDefault objectForKey:@"copyHistory"];
    NSMutableArray *historyArray = [NSMutableArray array];
    if (tempData != nil) {
        historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        for (int i = 0; i < historyArray.count; i++) {
            MKCopyItem *item = historyArray[i];
            if ([item.content isEqual:content]) {
//                if (i == historyArray.count - 1) {
//                    return;
//                }
//                [historyArray removeObject:item];
//                break;
                return;
            }
        }
    }
    [historyArray addObject:tempItem];
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:historyArray];
    [self.sharedUserDefault setObject:saveData forKey:@"copyHistory"];
    [self.sharedUserDefault synchronize];
}

- (void)deleteContent:(NSString *)content {
    [self setupSharedUserDefault];
    NSData *tempData = [self.sharedUserDefault objectForKey:@"copyHistory"];
    NSMutableArray *historyArray = [NSMutableArray array];
    if (tempData != nil) {
        historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        for (int i = 0; i < historyArray.count; i++) {
            MKCopyItem *tempItem = historyArray[i];
            if ([tempItem.content isEqual:content]) {
                [historyArray removeObjectAtIndex:i];
            }
        }
        NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:historyArray];
        [self.sharedUserDefault setObject:saveData forKey:@"copyHistory"];
        [self.sharedUserDefault synchronize];
    }

}

- (NSMutableArray *)pasteBoardHistory {
    [self setupSharedUserDefault];
    [self saveContent:[self currentPasteBoardContent]];
    NSData *tempData = [self.sharedUserDefault objectForKey:@"copyHistory"];
    NSMutableArray *historyArray = [NSMutableArray array];
    if (tempData != nil) {
        historyArray = [NSKeyedUnarchiver unarchiveObjectWithData:tempData];
        return historyArray;
    }
    return nil;
}

#pragma mark - date handler -
- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (NSString *)getTimeInterval:(NSString *)sendDateString {
    
    NSString *dateContent = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 当前时间 - 传过来的时间，就是时间差
    NSDate *currentDate = [NSDate date];
    currentDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:currentDate]];
    NSDate *endDate = [dateFormatter dateFromString:sendDateString];
    
    // 得到时间差
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:endDate];
    
    // 时间差的单位为秒, 1天 = 24 * 60 * 60, 1 h = 60 * 60,
    int days = ((int)timeInterval)/(3600*24);
    int hours = ((int)timeInterval)/3600;
    int minute = ((int)timeInterval)/60;
    if (days > 0) {
        dateContent = [NSString stringWithFormat:@"%d天前", days];
    } else if (hours > 0) {
        dateContent = [NSString stringWithFormat:@"%d小时前", hours];
    } else if (minute >= 1) {
        dateContent = [NSString stringWithFormat:@"%d分钟前", minute];
    } else {
        dateContent = @"刚刚";
    }
    return dateContent;
}

@end
