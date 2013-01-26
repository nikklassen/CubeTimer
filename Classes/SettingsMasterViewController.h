//
//  SettingsMasterViewController.h
//  CubeTimer
//
//  Created by Nik on 11-06-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CubeTimerViewController;
@class PuzzleTypeViewController;

#import "PuzzleTimeViewController.h"

extern NSString *selectedPuzzle;
extern int		newPuzzleID;

@interface SettingsMasterViewController : UITableViewController {
	
	UISwitch		*inspectionSwitch;
	NSMutableArray	*dataList;
	
}

@property (nonatomic, retain) IBOutlet UISwitch *inspectionSwitch;
@property (nonatomic, retain) NSMutableArray *dataList;

- (void) saveSettings;
- (void) returnToTimer;

@end

