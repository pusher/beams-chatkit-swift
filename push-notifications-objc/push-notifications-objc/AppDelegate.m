#import "AppDelegate.h"
@import BeamsChatkit;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[PushNotifications shared] startWithInstanceId:@"YOUR_INSTANCE_ID"]; // Can be found here: https://dash.pusher.com
    [[PushNotifications shared] registerForRemoteNotifications];

    NSError *anyError;
    [[PushNotifications shared] subscribeWithInterest:@"hello" error:&anyError completion:^{
        if (anyError) {
            NSLog(@"Error: %@", anyError);
        }
        else {
            NSLog(@"Subscribed to interest hello.");
        }
    }];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[PushNotifications shared] registerDeviceToken:deviceToken completion:^{}];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[PushNotifications shared] handleNotificationWithUserInfo:userInfo];
    NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Remote notification support is unavailable due to error: %@", error.localizedDescription);
}

@end
