//
//  RedBoxModel.h
//  RedEnvelopes
//
//  Created by 安风 on 2017/6/2.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedBoxModel : NSObject

@property(nonatomic,assign) BOOL isShow;
@property(nonatomic,strong) NSString* alertTitle;
@property(nonatomic,strong) NSString* alertText;
@end
