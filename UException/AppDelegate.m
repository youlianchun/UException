//
//  AppDelegate.m
//  UException
//
//  Created by YLCHUN on 2017/2/13.
//  Copyright © 2017年 ylchun. All rights reserved.
//

#import "AppDelegate.h"
#import "NSException+Signal.h"
#import "UException+Test.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

static void keeploop(void(^task)(void(^quit)(void))) {
    __block bool cancelRun = false;
    task(^void() {
        cancelRun = true;
    });
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    while (!cancelRun) {
        for (CFIndex i = CFArrayGetCount(allModes) - 1; i >= 0; i--) {
            CFStringRef model = CFArrayGetValueAtIndex(allModes, i);
            CFRunLoopRunInMode(model, 0.001, false);
            CFRelease(model);
        }
    }
    CFRelease(allModes);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    uExceptionHandler(YES, ^(UException *ue) {
//        exceptionAlert(ue);
    });

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


@end
