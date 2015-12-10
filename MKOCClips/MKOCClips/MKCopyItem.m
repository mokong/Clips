//
//  MKCopyItem.m
//  MKOCClips
//
//  Created by moyekong on 15/9/16.
//  Copyright (c) 2015年 wiwide. All rights reserved.
//

#import "MKCopyItem.h"

@interface MKCopyItem ()<NSCoding>

@end

@implementation MKCopyItem

- (id)initWithContent:(NSString *)content
                   date:(NSString *)saveDate
                 status:(NSNumber *)statusNumber
     pasteBoardSource:(NSString *)pasteBoardSource {
    self = [super init];
    if (self) {
        self.content = content;
        self.saveDate = saveDate;
        self.statusNumber = statusNumber;
        self.pasteBoardSource = pasteBoardSource;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.saveDate = [aDecoder decodeObjectForKey:@"saveDate"];
        self.statusNumber = [aDecoder decodeObjectForKey:@"statusNumber"];
        self.pasteBoardSource = [aDecoder decodeObjectForKey:@"pasteBoardSource"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.saveDate forKey:@"saveDate"];
    [aCoder encodeObject:self.statusNumber forKey:@"statusNumber"];
    [aCoder encodeObject:self.pasteBoardSource forKey:@"pasteBoardSource"];
}

@end
