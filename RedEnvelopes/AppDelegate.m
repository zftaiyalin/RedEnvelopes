//
//  AppDelegate.m
//  RedEnvelopes
//
//  Created by 曾富田 on 2017/5/10.
//  Copyright © 2017年 曾富田. All rights reserved.
//

#import "AppDelegate.h"
#import "NewViewController.h"
#import "YYModel.h"
#import "RedBoxModel.h"
#import "AppUnitl.h"
#import "RewardViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UMConfigInstance.appKey = @"592bbcf63eae25316d00206e";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSError *error = nil;
    
    NSString *ss = [NSString stringWithFormat:@"http://opmams01o.bkt.clouddn.com/redbox.json?v=%@",currentDateString];
    NSURL *xcfURL = [NSURL URLWithString:ss];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    
    RedBoxModel *model = [RedBoxModel yy_modelWithJSON:htmlString];
    
    [AppUnitl sharedManager].model = model;
    [AppUnitl sharedManager].model.isShow = YES;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    UINavigationController *secondNavigationController = [[UINavigationController alloc]
//                                                          initWithRootViewController:[[NewViewController alloc] init]];
    
    
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:[[RewardViewController alloc] init]];
    

    secondNavigationController.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [secondNavigationController.navigationBar setTitleTextAttributes:dict];
    
    
//    RewardViewController *vc = [[RewardViewController alloc]init];
    

    self.window.rootViewController = secondNavigationController;
    [self.window makeKeyAndVisible];
    
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
    
    return YES;
}

-(void)notice:(id)sender{
    NSLog(@"%@",sender);
    
    self.window.rootViewController = nil;
    
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:[[RewardViewController alloc] init]];
    
    
    secondNavigationController.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [secondNavigationController.navigationBar setTitleTextAttributes:dict];
    
    
    //    RewardViewController *vc = [[RewardViewController alloc]init];
    
    
    self.window.rootViewController = secondNavigationController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
