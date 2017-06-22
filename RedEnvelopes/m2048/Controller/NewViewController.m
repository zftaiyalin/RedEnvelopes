//
//  NewViewController.m
//  m2048
//
//  Created by 安风 on 2017/5/9.
//  Copyright © 2017年 Danqing. All rights reserved.
//
#import "M2ViewController.h"
#import "NewViewController.h"
#import "Masonry.h"
#import "NSObject+ALiHUD.h"
#import "KaiViewController.h"
#import "HongViewController.h"
#import "AppUnitl.h"

@interface NewViewController (){
    UIAlertView *pinlunAlert;
    int videoindex;
}

@end

@implementation NewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"Icon-App-72x72"];
    [self.view addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.top.equalTo(self.view.mas_centerY).offset(-100);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor colorWithHexString:@"#FF4040"];
    [button setTitle:@"Enter" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.layer.cornerRadius = 7;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageview.mas_bottom).offset(30);
    }];

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"pinglun"] && [AppUnitl sharedManager].model.isShow) {
        
        pinlunAlert = [[UIAlertView alloc] initWithTitle:[AppUnitl sharedManager].model.alertTitle message:[AppUnitl sharedManager].model.alertText delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"马上获取",nil];
        [pinlunAlert show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *str = [NSString stringWithFormat:
                         @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8",
                         @"1241876168"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pinglun"];
    }
}


-(void)push{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //将取出的storyboard里面的控制器被所需的控制器指着。
    M2ViewController *jVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"M2028ViewController"];
    [self presentViewController:jVC animated:NO completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
