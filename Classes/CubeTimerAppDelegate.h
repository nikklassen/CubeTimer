//
//  CubeTimerAppDelegate.h
//  CubeTimer
//
//  Created by Nik on 11-05-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CubeTimerViewController;

@interface CubeTimerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CubeTimerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CubeTimerViewController *viewController;

@end

