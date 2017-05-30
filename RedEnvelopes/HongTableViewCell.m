//
//  HongTableViewCell.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "HongTableViewCell.h"
#import "Masonry.h"

@implementation HongModel

@end

@implementation HongTableViewCell{

    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *sizeLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(13);
            make.left.equalTo(self.contentView).offset(23);
            make.height.mas_equalTo(20);
        }];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
        timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(titleLabel);
            make.height.mas_equalTo(15);
        }];
        
        
        sizeLabel = [[UILabel alloc]init];
        sizeLabel.textColor = [UIColor blackColor];
        sizeLabel.font = [UIFont systemFontOfSize:15];
        sizeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:sizeLabel];
        
        [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel).offset(-4);
            make.right.equalTo(self.contentView).offset(-20);
            make.height.mas_equalTo(20);
        }];
        
//        UIView *line = [[UIView alloc]init];
//        line.backgroundColor = [UIColor colorWithHexString:@"#515151"];
//        [self.contentView addSubview:line];
//        
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.bottom.and.right.equalTo(self.contentView);
//            make.height.mas_equalTo(0.5);
//        }];
    }
    return self;
}

-(void)setData:(HongModel *)model{
    titleLabel.text = model.name;
    timeLabel.text = @"08-10";
    sizeLabel.text = [NSString stringWithFormat:@"%@.00元",model.money];
}
@end
