//
//  MKCopyItem.h
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKCopyItem : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *saveDate;
@property (nonatomic, strong) NSNumber *statusNumber;
@property (nonatomic, strong) NSString *pasteBoardSource;

- (id)initWithContent:(NSString *)content
                 date:(NSString *)saveDate
               status:(NSNumber *)statusNumber
     pasteBoardSource:(NSString *)pasteBoardSource;

@end
