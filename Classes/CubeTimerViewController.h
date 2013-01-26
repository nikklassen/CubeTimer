//
//  CubeTimerViewController.h
//  CubeTimer
//
//  Created by Nik on 11-05-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SettingsMasterViewController.h"

#define running YES
#define stopped NO

// Settings related variables, to be accessed in SettingsViewController
extern BOOL				inspection;
extern NSUserDefaults	*prefs;
extern int				cubeSize;
extern NSString			*puzzleType;
extern UILabel			*scrambleLbl;
extern UIButton			*viewScramble;

@interface CubeTimerViewController : UIViewController <UIAlertViewDelegate> {

	UIButton		*timerBtn;
	UILabel			*timerLbl;
	AVAudioPlayer	*beepSound, *finalBeep;
	BOOL			timerState;
	NSTimer			*timer, *inspectionTimer;
	NSTimeInterval	startTime, currentTime, elapsedTime, countdownTime;
	int				scrambleLength;
	
}

@property (nonatomic, retain) IBOutlet UIButton *timerBtn, *viewScramble;
@property (nonatomic, retain) IBOutlet UILabel *timerLbl, *scrambleLbl;
@property (nonatomic, assign) BOOL timerState;

- (IBAction) timer: (id) sender;
- (IBAction) showLongScramble: (id) sender;
- (IBAction) showLastTimes: (id) sender;
- (IBAction) showSettings: (id) sender;
- (void) showTime;
- (void) inspectionTimer;
- (NSMutableString *) standardScramble;
- (NSMutableString *) megaminxScramble;
- (void) refreshView: (NSNotification *) notification;
- (NSMutableString *) getPuzzleTime;
- (IBAction) modTime: (id)sender;
- (void) saveTime: (int) saveTag;
- (void) timeAlert;

- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

