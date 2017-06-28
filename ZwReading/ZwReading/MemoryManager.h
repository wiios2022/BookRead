//
//  MemoryManager.h
//  ZwReading
//
//  Created by DengZw on 2017/6/27.
//  Copyright © 2017年 ALonelyEgg.com. All rights reserved.
//

#import <Foundation/Foundation.h>


// 阅读纪录

@interface MemoryManager : NSObject

+ (instancetype)sharedInstance;

- (void)saveHeight:(double)height book:(NSString *)name;
- (double)loadHeightByBook:(NSString *)name;

@end
