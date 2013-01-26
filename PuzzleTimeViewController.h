//
//  PuzzleTimeViewController.h
//  CubeTimer
//
//  Created by Nik on 11-07-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CubeTimerViewController.h"
#import "SettingsMasterViewController.h"
#import "TimesViewController.h"
#import <UIKit/UIKit.h>

@class CubeTimerViewController;
@class SettingsMasterViewController;

@interface PuzzleTimeViewController : UITableViewController {

	NSArray	*stackStyle;
	NSArray	*puzzles;
	NSArray	*data;
	
}

@property (nonatomic, retain) NSArray *stackStyle, *puzzles, *data;

@end
