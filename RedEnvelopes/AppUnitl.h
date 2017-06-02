//
//  AppUnitl.h
//  RedEnvelopes
//
//  Created by 安风 on 2017/6/2.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedBoxModel.h"
@interface AppUnitl : NSObject
@property(nonatomic,strong) RedBoxModel *model;

+ (AppUnitl *)sharedManager;
@end
