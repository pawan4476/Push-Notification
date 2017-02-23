//
//  AppDelegate.m
//  PushNotificationDemo
//
//  Created by test on 2/21/17.
//  Copyright © 2017 com.meheboob. All rights reserved.
//

#import "AppDelegate.h"
#import <Pushbots/Pushbots.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.pushbotsClient = [[Pushbots alloc] initWithAppId:@"58abf1a84a9efa3ffc8b4567" prompt:YES];
    [self.pushbotsClient trackPushNotificationOpenedWithLaunchOptions:launchOptions];
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        if (aps) {
            NSString *alertMsg = [aps objectForKey:@"alert"];
               NSLog(@"Notification message: %@", alertMsg);
        }
        NSString *articleID = [userInfo objectForKey:@"articleId"];
    }
    return YES;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [Pushbots openURL:userInfo];
    if (application.applicationState == UIApplicationStateInactive) {
        [self.pushbotsClient trackPushNotificationOpenedWithPayload:userInfo];
    }
    
    if (application.applicationState == UIApplicationStateActive) {
        NSDictionary *notificationDict = [userInfo objectForKey:@"aps"];
        NSString *alertString = [notificationDict objectForKey:@"alert"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Push Notification Received" message:alertString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [self.pushbotsClient registerOnPushbots:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"notification register error %@", [error description]);
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
