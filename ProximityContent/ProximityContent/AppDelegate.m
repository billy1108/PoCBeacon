//
//  AppDelegate.m
//  ProximityContent
//

#import "AppDelegate.h"

@interface AppDelegate () <ESTBeaconManagerDelegate>

@property(strong, nonatomic) ESTBeaconManager *beaconManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  put your App ID and App Token here
    // You can get them by adding your app on https://cloud.estimote.com/#/apps
    [ESTConfig setupAppID:@"coupin" andAppToken:@"02cfde70285f0c95298ca645016e1096"];
  
    self.beaconManager = [ESTBeaconManager new];
    [self.beaconManager requestAlwaysAuthorization];
    self.beaconManager.delegate = self;
    [self.beaconManager requestAlwaysAuthorization];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    
    // don't forget the NSLocationAlwaysUsageDescription in your Info.plist
    
    NSUUID *uuid = [[NSUUID UUID] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-00007B57FE6D"];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                     major:27305
                                                                     minor:9482
                                                                identifier:@"AppRegion"];
    [self.beaconManager startMonitoringForRegion:region];
    //[self.beaconManager startRangingBeaconsInRegion:region];
    

    return YES;
}

-(void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Enter region";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

-(void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(CLBeaconRegion *)region
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Exit region";
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
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
