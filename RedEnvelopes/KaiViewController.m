//
//  KaiViewController.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "KaiViewController.h"
#import "Masonry.h"

@interface KaiViewController ()

@end

@implementation KaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"插件总开关";
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection=YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section <= 3 && section > 0) {
        return 55;
    }else{
        return 15;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section <= 3 && section > 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
        view.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(13, 0, self.view.width -13, 30);
        label.textColor = [UIColor colorWithHexString:@"#888888"];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        if (section == 1) {
            label.text = @"推荐设置随机延迟，推荐依次轮流去抢。";
        }else if (section == 2) {
            label.text = @"设置不抢指定群/指定人的红包。";
        }else if (section == 3) {
            label.text = @"当祝福红包语中包含指定话语时，不抢红包。";
        }
        
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 15)];
        view.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
        return view;
    }


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"插件总开关";
        
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"每次随机延迟最大秒数";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 2) {
        cell.textLabel.text = @"当有多个红包时同时抢";
        
    }else if (indexPath.section == 3) {
        cell.textLabel.text = @"不抢包含关键词的红包";
        
    }else if (indexPath.section == 4) {
        cell.textLabel.text = @"抢到后随机回复感谢语";
        
    }else{
        cell.textLabel.text = @"抢到后通知我红包金额";
    }
    
    if (indexPath.section != 1) {
         UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.width - 60, 0, 40.0f, 28.0f)];
        switchView.centerY = cell.contentView.centerY;
        [cell.contentView addSubview:switchView];
    }
    return cell;
}

@end
