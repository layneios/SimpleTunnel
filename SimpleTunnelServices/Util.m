//
//  Util.m
//  SimpleTunnel
//
//  Created by Layne on 16/11/16.
//  Copyright © 2016年 Layne. All rights reserved.
//

#import "Util.h"

@implementation Util


@end


@implementation SavedData

- (void)append:(NSData *)data offset:(NSInteger)offset {
    NSMutableArray *tempArray = [self.chain mutableCopy];
    NSDictionary *dict = @{@"data":data, @"offset":@(offset)};
    [tempArray addObject:dict];
    self.chain = [tempArray copy];
}

- (BOOL)isEmpty {
    return self.chain.count == 0;
}

- (BOOL)writeToStream:(NSOutputStream *)stream {
    BOOL result = YES;
    NSInteger stopIndex = 0;
    for (NSDictionary *dict in self.chain) {
        
    }
    return result;
}

@end
