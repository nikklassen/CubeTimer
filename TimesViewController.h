//
//  TimesViewController.h
//  CubeTimer
//
//  Created by Nik on 11-07-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsMasterViewController.h"
#import "PuzzleTimeViewController.h"

@class SettingsMasterViewController;
@class PuzzleTimeViewController;

@interface TimesViewController : UITableViewController {

	NSArray *times;
}

@property (nonatomic, retain) NSArray *times;

@end
