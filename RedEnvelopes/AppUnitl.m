//
//  AppUnitl.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/6/2.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "AppUnitl.h"


@implementation AppUnitl

+ (AppUnitl *)sharedManager
{
    static AppUnitl *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


@end
