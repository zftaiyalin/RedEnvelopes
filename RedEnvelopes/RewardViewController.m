//
//  RewardViewController.m
//  RedEnvelopes
//
//  Created by 安风 on 2017/6/3.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "RewardViewController.h"
#import "NSObject+ALiHUD.h"
@import GoogleMobileAds;

@interface RewardViewController ()<GADRewardBasedVideoAdDelegate>{

    BOOL isRequestVideo;
    int videoindex;
    BOOL isStart;
    BOOL realyPlay;
}

@end

@implementation RewardViewController

- (void)requestRewardedVideo {
    GADRequest *request = [GADRequest request];
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:request
                                           withAdUnitID:@"ca-app-pub-3676267735536366/8845808532"];
}


-(void)huoqujifen{
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }else{
        [self requestRewardedVideo];
        isRequestVideo = YES;
        [self showText:@"正在获取权限广告"];
        [self performSelector:@selector(pushRequest) withObject:nil afterDelay:15];
    }
}

-(void)pushRequest{
    if (!isStart) {
        [self requestRewardedVideo];
        [self performSelector:@selector(pushRequest) withObject:nil afterDelay:15];
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pushRequest) object:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [self requestRewardedVideo];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(huoqujifen) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)pushVideo{
    [GADRewardBasedVideoAd sharedInstance].delegate = nil;
    //创建一个消息对象
//    NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"123"}];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [self huoqujifen];
}

-(void)loadVideo{
    if (!realyPlay) {
        [self huoqujifen];
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
    isStart = YES;
    realyPlay = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pushVideo) object:nil];
    [self performSelector:@selector(loadVideo) withObject:nil afterDelay:5];
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
    NSLog(@"admob奖励视频开始播放");
    realyPlay = YES;
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    NSLog(@"关闭admob奖励视频");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSLog(@"有效的播放admob奖励视频");
    isStart = NO;
    realyPlay = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(pushVideo) object:nil];
    [self pushVideo];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
    NSLog(@"点击admo奖励视频准备离开app");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    rewardBasedVideoAdDidReceiveAd:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    NSLog(@"admob奖励视频加载失败");
    if (isRequestVideo) {
        isRequestVideo = NO;
        [self dismissLoading];
        
        [self showErrorText:@"获取广告失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissLoading];
            [self huoqujifen];
        });
    }
}


@end
