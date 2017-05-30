//
//  HongViewController.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/5/30.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "HongViewController.h"
#import "Masonry.h"


@interface HongViewController (){

    NSMutableArray *tableAry;
}

@end

@implementation HongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTableData];
    self.title = @"收到的红包";
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection=YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
    [self.tableView registerClass:[HongTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    
    [self.tableView setTableHeaderView:[self tableheadView]];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

-(void)creatTableData{

    tableAry = [NSMutableArray array];
    
    NSArray *name =  [NSArray arrayWithObjects:@"傲似公主",@"う呸侢裗蒗",@"重拾记忆",@"橙熟 ˇ柚稚",@"少女与猫",@"影子",@"A…傻瓜",@"抱抱啊霖",@"℡此女子の邪魅",@"水晶～沬兮",@"你不配",@"怪我喽", nil];
    
    NSArray *money =  [NSArray arrayWithObjects:@"133",@"200",@"443",@"27",@"66",@"88",@"111",@"199",@"9",@"100",@"200",@"55", nil];
    
    for (int i = 0; i< 12 ; i++) {
        HongModel *model = [[HongModel alloc]init];
        model.name = [name objectAtIndex:i];
        model.money = [money objectAtIndex:i];
        [tableAry addObject:model];
    }

}

-(UIView *)tableheadView{
    UIView *head = [[UIView alloc]init];
    head.backgroundColor = [UIColor colorWithHexString:@"#f0eff4"];
    head.frame = CGRectMake(0, 0, self.view.width, 330);
    
    
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"timg.jpeg"];
    image.clipsToBounds = YES;
    image.layer.cornerRadius = 30;
    [head addSubview: image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(head).offset(40);
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"Clover共收到";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:16];
    [head addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(head);
        make.top.equalTo(image.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *money = [[UILabel alloc]init];
    money.text = @"400403.18";
    money.textAlignment = NSTextAlignmentCenter;
    money.font = [UIFont systemFontOfSize:40];
    [head addSubview:money];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(head);
        make.top.equalTo(title.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];

    
    UILabel *hongNum = [[UILabel alloc]init];
    hongNum.text = @"699";
    hongNum.textColor = [UIColor colorWithHexString:@"#a4a4a6"];
    hongNum.textAlignment = NSTextAlignmentCenter;
    hongNum.font = [UIFont systemFontOfSize:25];
    [head addSubview:hongNum];
    
    [hongNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head).offset(80);
        make.top.equalTo(money.mas_bottom).offset(25);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *honglabel = [[UILabel alloc]init];
    honglabel.text = @"收到红包";
    honglabel.textColor = [UIColor colorWithHexString:@"#a4a4a6"];
    honglabel.textAlignment = NSTextAlignmentCenter;
    honglabel.font = [UIFont systemFontOfSize:13];
    [head addSubview:honglabel];
    
    [honglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(hongNum);
        make.top.equalTo(hongNum.mas_bottom).offset(5);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *shouNum = [[UILabel alloc]init];
    shouNum.text = @"612";
    shouNum.textColor = [UIColor colorWithHexString:@"#a4a4a6"];
    shouNum.textAlignment = NSTextAlignmentCenter;
    shouNum.font = [UIFont systemFontOfSize:25];
    [head addSubview:shouNum];
    
    [shouNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(head).offset(-80);
        make.top.equalTo(money.mas_bottom).offset(25);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *shoulabel = [[UILabel alloc]init];
    shoulabel.text = @"手气最佳";
    shoulabel.textColor = [UIColor colorWithHexString:@"#a4a4a6"];
    shoulabel.textAlignment = NSTextAlignmentCenter;
    shoulabel.font = [UIFont systemFontOfSize:13];
    [head addSubview:shoulabel];
    
    [shoulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shouNum);
        make.top.equalTo(shouNum.mas_bottom).offset(5);
        make.height.mas_equalTo(22);
    }];

    
    
    return head;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return tableAry.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HongTableViewCell *cell = (HongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    HongModel *dd = [tableAry objectAtIndex:indexPath.row];
    [cell setData:dd];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
