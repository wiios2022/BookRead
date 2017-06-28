//
//  MemoryManager.m
//  ZwReading
//
//  Created by DengZw on 2017/6/27.
//  Copyright © 2017年 ALonelyEgg.com. All rights reserved.
//

#import "MemoryManager.h"

@interface MemoryManager ()

@property (nonatomic, strong) NSUserDefaults *userDefaluts; /**< <#注释文字#> */

@end

@implementation MemoryManager

+ (instancetype)sharedInstance
{
    static MemoryManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.userDefaluts = [NSUserDefaults standardUserDefaults];
    });
    
    return instance;
}


- (void)saveHeight:(double)height book:(NSString *)name
{
    [self.userDefaluts setObject:[NSString stringWithFormat:@"%f", height] forKey:name];
    [self.userDefaluts synchronize];
}

- (double)loadHeightByBook:(NSString *)name
{
    return [[self.userDefaluts objectForKey:name] doubleValue];
}

@end
