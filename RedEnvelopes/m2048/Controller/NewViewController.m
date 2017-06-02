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
@import GoogleMobileAds;

@interface NewViewController ()<GADRewardBasedVideoAdDelegate>{
    BOOL isAdmob;
    BOOL isRequestVideo;
    UIAlertView *pinlunAlert;
}
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation NewViewController

-(void)huoqujifen{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }else{
        [self requestRewardedVideo];
        isRequestVideo = YES;
        [self showText:@"正在获取积分广告"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff5"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"观看广告" style:UIBarButtonItemStylePlain target:self action:@selector(huoqujifen)];
    
    self.navigationItem.rightBarButtonItem = item;
    
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
    
    GADBannerView *ban = [[GADBannerView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 50)];
    ban.adUnitID = @"ca-app-pub-3676267735536366/9857026939";
    ban.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    [ban loadRequest:request];
    
    [self.view addSubview:ban];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
    }];
    
    if (![[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [self requestRewardedVideo];
    }
    
    [self createAndLoadInterstitial];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"pinglun"] && [AppUnitl sharedManager].model.isShow) {
        
        pinlunAlert = [[UIAlertView alloc] initWithTitle:[AppUnitl sharedManager].model.alertTitle message:[AppUnitl sharedManager].model.alertText delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"马上获取",nil];
        [pinlunAlert show];
        
    }
}


- (void)requestRewardedVideo {
    GADRequest *request = [GADRequest request];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:@"ca-app-pub-3676267735536366/3810493335"];
}

- (void)createAndLoadInterstitial {
    self.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3676267735536366/5287226536"];
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made.
//    request.testDevices = @[ kGADSimulatorID, @"fe9239b402756b9539e3beb3a686378d" ];
    [self.interstitial loadRequest:request];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"自动抢红包插件";
       
    }else{
        cell.textLabel.text = @"查看抢红包战绩";
           }
    return cell;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView == pinlunAlert) {
            NSString *appID = @"1241876168";
            NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pinglun"];
        }else{
            [self huoqujifen];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    HongViewController *ss = [[HongViewController alloc]init];
//    [self.navigationController pushViewController:ss animated:YES];
    
        if (indexPath.section == 0) {
            
            
            UIAlertView *infoAlert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"观看广告开启插件" delegate:self   cancelButtonTitle:@"待会儿" otherButtonTitles:@"观看",nil];
            [infoAlert show];
            
            
        }else{
            
            if (self.interstitial.isReady && !isAdmob) {
                isAdmob = YES;
                [self.interstitial presentFromRootViewController:self];
                
            }else{
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                //将取出的storyboard里面的控制器被所需的控制器指着。
                M2ViewController *jVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"M2028ViewController"];
                [self presentViewController:jVC animated:NO completion:^{
                    
                }];
            }
        }

  
    
}


#pragma mark GADRewardBasedVideoAdDelegate implementation

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    if (isRequestVideo) {
        isRequestVideo = NO;
        [self dismissLoading];
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
    NSLog(@"admob奖励视频开始播放");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    NSLog(@"中途关闭admob奖励视频");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSLog(@"有效的播放admob奖励视频");
    
   
    [self showErrorText:@"观看广告失败"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissLoading];
        
    });
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
    NSLog(@"点击admo奖励视频准备离开app");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    NSLog(@"admob奖励视频加载失败");
    if (isRequestVideo) {
        isRequestVideo = NO;
        [self dismissLoading];
        
        [self showErrorText:@"获取广告失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
        });
    }
}


@end
