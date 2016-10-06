//
//  AppDelegate.m
//  sampleCode
//
//  Created by Kalpesh Parikh on 10/5/16.
//  Copyright © 2016 kalpesh parikh. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIColor+HexString.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    ViewController *myViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    
    // setting properies to navigation bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorwithHexString:@"ffffff" alpha:1.0], NSForegroundColorAttributeName,shadow,NSShadowAttributeName,[UIFont fontWithName:@"Machinato-Light" size:20],NSFontAttributeName, nil]];
    
    
    // setting properies to navigation controller
    self.navController = [[UINavigationController alloc] initWithRootViewController:myViewController];
    [self.navController setNavigationBarHidden:NO];
    self.navController.navigationBar.tintColor = [UIColor whiteColor];
    
    if ([self.navController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navController.navigationBar setBarTintColor:[UIColor colorwithHexString:@"#2c4556" alpha:0.9]];
    }
    else {
        [self.navController.navigationBar setTintColor:[UIColor colorwithHexString:@"#2c4556" alpha:0.9]];
    }
     
    self.window.rootViewController = self.navController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
