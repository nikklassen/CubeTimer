//
//  PuzzleTypeViewController.h
//  CubeTimer
//
//  Created by Nik on 11-06-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPuzzleViewController.h"

@class CubeTimerViewController;
@class SettingsMasterViewController;

extern NSMutableArray	*puzzles;
extern NSArray			*stackStyle;

@interface PuzzleTypeViewController : UITableViewController {

	NSMutableArray	*data;
	NSIndexPath		*currentPuzzle;
	
}

@property (nonatomic, retain, getter = myNewPuzzleName) UITextField *newPuzzleName;
@property (nonatomic, retain) NSMutableArray *data;

@end
