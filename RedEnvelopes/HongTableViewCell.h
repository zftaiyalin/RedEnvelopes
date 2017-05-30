//
//  HongTableViewCell.h
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HongModel : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *money;
@property(nonatomic,strong) NSString *time;

@end

@interface HongTableViewCell : UITableViewCell

-(void)setData:(HongModel *)model;



@end
