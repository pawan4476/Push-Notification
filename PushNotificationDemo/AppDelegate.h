//
//  AppDelegate.h
//  PushNotificationDemo
//
//  Created by test on 2/21/17.
//  Copyright © 2017 com.meheboob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pushbots/Pushbots.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Pushbots *pushbotsClient;

@end

