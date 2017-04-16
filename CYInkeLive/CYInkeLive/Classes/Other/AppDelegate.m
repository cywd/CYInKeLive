//
//  AppDelegate.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "AppDelegate.h"
#import "CYTabBarController.h"
#import <SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 异常处理
    [self installUncaughtExceptionHandler];
    
    self.window= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    CYTabBarController *tabbarVC = [[CYTabBarController alloc] init];
    self.window.rootViewController = tabbarVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清除缓存
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}

// 获取崩溃日志
- (void)installUncaughtExceptionHandler {
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://lichunyang@outlook.com?subjectBug&body=感谢您的配合！<br><br><br>""错误详情(%@):<br>%@<br>--------------------------<br>%@<br>-------------<br>%@", currentVersion, name, reason, [arr componentsJoinedByString:@"<br>"]];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
