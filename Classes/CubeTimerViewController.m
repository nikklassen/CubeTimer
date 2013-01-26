//
//  CubeTimerViewController.m
//  CubeTimer
//
//  Created by Nik on 11-05-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CubeTimerViewController.h"

BOOL			inspection = NO;
NSUserDefaults	*prefs = nil;
int				cubeSize;
NSString		*puzzleType = nil;
UIButton		*viewScramble = nil;

@implementation CubeTimerViewController

@synthesize timerBtn, viewScramble, timerLbl, scrambleLbl, timerState;

- (IBAction) timer: (id) sender {
	
	if (timerState == stopped) {
		
		timerState = running;
		
		if (!inspection) {
			
			startTime = [NSDate timeIntervalSinceReferenceDate];
			timer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(showTime) userInfo: nil repeats: YES];
			
		} else {
			
			[timerBtn setEnabled: NO];
			startTime = [NSDate timeIntervalSinceReferenceDate];
			[timerLbl setText: @"15"];
			inspectionTimer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target: self selector: @selector(inspectionTimer) userInfo: nil repeats: YES];
			
		}
		
		
	} else {
		
		timerState = stopped;
		
		currentTime = [NSDate timeIntervalSinceReferenceDate];
		elapsedTime = currentTime - startTime;
		
		if (elapsedTime < 10)
			[timerLbl setText: [NSString stringWithFormat: @"0%.2f", elapsedTime]];
		else
			[timerLbl setText: [NSString stringWithFormat: @"%.2f", elapsedTime]];
		[timer invalidate];
		
		[scrambleLbl setText: [self standardScramble]];
		
		[self timeAlert];
	}
	
	
}

- (void) showTime {
	
	currentTime = [NSDate timeIntervalSinceReferenceDate];
	elapsedTime = currentTime - startTime;
	
	if (elapsedTime < 10)
		[timerLbl setText: [NSString stringWithFormat: @"0%.2f", elapsedTime]];
	else
		[timerLbl setText: [NSString stringWithFormat: @"%.2f", elapsedTime]];
}

- (void) inspectionTimer {
	
	currentTime = [NSDate timeIntervalSinceReferenceDate];
	elapsedTime = currentTime - startTime;
	
	countdownTime = 15 - elapsedTime;
	
	if ((countdownTime > 1.50 && countdownTime < 1.52) || (countdownTime > 2.50 && countdownTime < 2.52) || (countdownTime > 3.50 && countdownTime < 3.52))
		[beepSound play];
	
	if (countdownTime > 0.50 && countdownTime < 0.52) {
		[finalBeep play];
		[inspectionTimer invalidate];
		[timerBtn setEnabled: YES];
		startTime = [NSDate timeIntervalSinceReferenceDate];
		timer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(showTime) userInfo: nil repeats: YES];
	}
	
	[timerLbl setText: [NSString stringWithFormat: @"%.0f", countdownTime]];
}

- (NSMutableString *) standardScramble {

	NSMutableString *s = [[NSMutableString alloc] init];
	NSString *moveToAdd;
	
	int numMoves = 0;
	
	BOOL setDoubleA = NO;
	BOOL doubleA = NO;
	BOOL doubleMove = NO;
	
	// x (like R) = 0, y (like U) = 1, z (like F) = 2
	typedef enum {
		x,
		y,
		z
	} Axis;
	
	int lastMove;
	int lastAxis;
	
	typedef enum {
		front,
		right,
		up,
		back,
		left,
		down
	} Face;
	
	typedef enum {
		clockwise,
		prime,
		twice
	} Direction;
	
	// set scrambleLength
	switch (cubeSize) {
		case 2:
			scrambleLength = 25;
			break;
		case 3:
			scrambleLength = 25;
			break;
		case 4:
			scrambleLength = 40;
			break;
		case 5:
			scrambleLength = 60;
			break;
		case 6:
			scrambleLength = 80;
			break;
		case 7:
			scrambleLength = 100;
			break;
		default:
			break;
	}
    
	while (numMoves < scrambleLength) {
		int face = arc4random() % 6;
		int direction = arc4random() % 3;
		int slice;
		
		switch (face) {
			case front:
				
				if ((!doubleA || (doubleA && lastAxis != z)) && lastMove != front) {
					moveToAdd =  @"F";
					doubleA = NO;
				}
				
				if (lastAxis != z)
					lastAxis = z;
				else
					setDoubleA = YES;
				
				if (lastMove != front ) {
					lastMove = front;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				
				break;
			case right:
				
				if ((!doubleA || (doubleA && lastAxis != x)) && lastMove != right) {
					moveToAdd =  @"R";
					doubleA = NO;
				}
				
				if (lastAxis != x)
					lastAxis = x;
				else
					setDoubleA = YES;
				
				if (lastMove != right ) {
					lastMove = right;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				break;
			case up:
				
				if ((!doubleA || (doubleA && lastAxis != y)) && lastMove != up) {
					moveToAdd = @"U";
					doubleA = NO;
				}
				
				if (lastAxis != y)
					lastAxis = y;
				else
					setDoubleA = YES;
				
				if (lastMove != up) {
					lastMove = up;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				break;
			case back:
				
				if ((!doubleA || (doubleA && lastAxis != z)) && lastMove != back) {
					moveToAdd =  @"B";
					doubleA = NO;
				}
				
				if (lastAxis != z)
					lastAxis = z;
				else
					setDoubleA = YES;
				
				if (lastMove != back) {
					lastMove = back;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				break;
			case left:
				
				if ((!doubleA || (doubleA && lastAxis != x)) && lastMove != left) {
					moveToAdd =  @"L";
					doubleA = NO;
				}
				
				if (lastAxis != x)
					lastAxis = x;
				else
					setDoubleA = YES;
				
				if (lastMove != left) {
					lastMove = left;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				break;
			case down:
				
				if ((!doubleA || (doubleA && lastAxis != y)) && lastMove != down) {
					moveToAdd =  @"D";
					doubleA = NO;
				}
				
				if (lastAxis != y)
					lastAxis = y;
				else
					setDoubleA = YES;
				
				if (lastMove != down) {
					lastMove = down;
					doubleMove = NO;
				}
				else {
					doubleMove = YES;
				}
				
				break;
			default:
				break;
		}
		
		if (!doubleA && !doubleMove) {
			
			if (cubeSize < 6)
				slice = arc4random() % 2;
			else {
				slice = arc4random() % 3;
				if (slice != 0)
					[s appendString: [NSString stringWithFormat: @"%i", (slice+1)]];
			}
			
			[s appendString: moveToAdd];
			
			if (slice == 1 && (cubeSize == 4 || cubeSize == 5)) {
				[s appendString: @"w"];
			}
			
			switch (direction) {
				case clockwise:
					[s appendString: @" "];
					break;
				case prime:
					[s appendString: @"' "];
					break;
				case twice:
					[s appendString: @"2 "];
					break;
				default:
					break;
			}
			
			numMoves += 1;
		}
		
		if (setDoubleA) {
			doubleA = YES;
			setDoubleA = NO;
		}
		
	}
	
	return s;
	
}

- (void) refreshView: (NSNotification *) notification {
	
	[scrambleLbl setText: [self standardScramble]];
	if (cubeSize > 3)
		viewScramble.hidden = NO;
	
}

- (NSMutableString *) megaminxScramble {
	
	NSMutableString *s = [[NSMutableString alloc] init];
	int scrambleNums[70];
	
	for (int n = 0; n < 70; n++)
		scrambleNums[n] = arc4random() % 2;
	
	for (int j = 0; j < 7; j++) {
		for (int i = 0; i < 10; i++) {
			
			if (i % 2) {
				if (scrambleNums[j*10 + i])
					[s appendString: @"D++ "];
				else {
					[s appendString: @"D-- "];
				}
			} else {
				if (scrambleNums[j*10 + i])
					[s appendString: @"R++ "];
				else {
					[s appendString: @"R-- "];
				}
			}
		}
		
		if (scrambleNums[(j+1)*10 - 1])
			[s appendString: @"U\n"];
		else {
			[s appendString: @"U'\n"];
		}
		
	}
	
	return s;
}

-(IBAction) showLongScramble: (id) sender {
	
	UIAlertView *showScramble = [[UIAlertView alloc] initWithTitle: @"Scramble"
														   message: scrambleLbl.text
														  delegate: self
												 cancelButtonTitle: @"Close"
												 otherButtonTitles: nil];
	
	[showScramble show];
}

- (void) timeAlert {
	
	UIAlertView *confirmTime = [UIAlertView new];
	[confirmTime setTitle: @"Save Time?"];
	[confirmTime setMessage: [NSString stringWithFormat: @"Your time was %.2f.  Would you like to save this time?", elapsedTime]];
	[confirmTime setDelegate: self];
	[confirmTime addButtonWithTitle: @"Discard"];
	[confirmTime addButtonWithTitle: @"Save/Change"];	
	confirmTime.tag = 1;
	
	[confirmTime show];
}

- (IBAction) modTime : (id) sender {
	[self saveTime: [sender tag]];
}

- (void) saveTime : (int) saveTag {
	
	// Locate the times plist
	NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *timesPath = [documentDirectory stringByAppendingPathComponent: @"times"];
	
	// Variable to detect the existance of aforementioned plist
	BOOL timesFileExists = [[NSFileManager defaultManager] fileExistsAtPath: timesPath];
	
	// Dictionary to hold all contents of the plist
	NSMutableDictionary *times;
	
	// Array to hold all the times
	NSMutableArray *newTimes = [[NSMutableArray alloc] initWithCapacity: 13];
	
	if (timesFileExists) {
		
		// If the plist exists then populate the dictionary with the contents
		times = [[NSMutableDictionary alloc] initWithContentsOfFile: timesPath];
		
		// Populate the array with the times for the puzzle currently in use
		if ([times objectForKey: [self getPuzzleTime]])
			newTimes = [times objectForKey: [self getPuzzleTime]];
		
	} else {
		
		times = [[NSMutableDictionary alloc] init];
	}
	
	float timeToEdit;
	
	switch (saveTag) {
		case 0:
			// Add the current time to the array	
			[newTimes addObject: [NSNumber numberWithFloat: elapsedTime]];
			
			// If this is the 13th time erase the first one
			if ([newTimes count] == 13) {
				[newTimes removeObjectAtIndex: 0];
			}
			
			// Rewrite the array to the dictionary under the correct key
			[times setObject: newTimes forKey: [self getPuzzleTime]];			
			break;
		case 1:
			timeToEdit = [[newTimes objectAtIndex: ([newTimes count] - 1)] floatValue];
			timeToEdit += 2;
			[newTimes replaceObjectAtIndex: ([newTimes count] - 1) withObject: [NSNumber numberWithFloat: timeToEdit]];
			break;
		case 2:
			timeToEdit = [[newTimes objectAtIndex: ([newTimes count] - 1)] floatValue];
			timeToEdit = -1;
			[newTimes replaceObjectAtIndex: ([newTimes count] - 1) withObject: [NSNumber numberWithFloat: timeToEdit]];
			break;
		default:
			break;
	}
	
		
	// Rewrite the dictionary to the plist (or create the plist if it isn't already there						 
	[times writeToFile: timesPath atomically: YES];
	
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	if (alertView.tag == 1) {
		if (buttonIndex != 0) {
			
			[self saveTime: 0];
			
		}
		
	} else if (alertView.tag == 2) {
		
		if (buttonIndex == 1) {
			
			NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
			NSString *timesPath = [documentDirectory stringByAppendingPathComponent: @"times"];
			
			NSMutableDictionary *allTimes = [[NSMutableDictionary alloc] initWithContentsOfFile: timesPath];
			
			[allTimes removeObjectForKey: [self getPuzzleTime]];
			[allTimes writeToFile: timesPath atomically: YES];
		}
		
	}
}

- (IBAction) showLastTimes: (id) sender {
	
	// String to hold the times being displayed
	NSMutableString *timesString = [[NSMutableString alloc] init];	
	
	NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSString *timesPath = [documentDirectory stringByAppendingPathComponent: @"times"];
	
	UIAlertView *showTimes;
	
	if ([[NSFileManager defaultManager] fileExistsAtPath: timesPath]) {
		
		NSMutableDictionary *allTimes = [[NSMutableDictionary alloc] initWithContentsOfFile: timesPath];
		
		NSMutableArray *timesToShow = [[NSMutableArray alloc] initWithCapacity: 12];
		
		timesToShow = [allTimes objectForKey: [self getPuzzleTime]];
		
		for (int i = 0; i < timesToShow.count; i++) {
			if ([[timesToShow objectAtIndex: i] floatValue] == -1) {
				[timesString appendString: @"POP"];
			} else {
				[timesString appendString: [NSString stringWithFormat: @"%.2f", [[timesToShow objectAtIndex: i] floatValue]]];
			}
			
			if (i != timesToShow.count - 1)
				[timesString appendString: @", "];
		}
		
		if (timesToShow != 0)
			showTimes = [[UIAlertView alloc] initWithTitle: @"Last 12 Times"
												   message: timesString
												  delegate: self
										 cancelButtonTitle: @"Close"
										 otherButtonTitles: @"Clear Session", nil];
		else
			showTimes = [[UIAlertView alloc] initWithTitle: @"Last 12 Times"
												   message: @"There are no times recorded for this puzzle."
												  delegate: self
										 cancelButtonTitle: @"Close"
										 otherButtonTitles: nil];
		
		showTimes.tag = 2;
		
	} else {
		
		showTimes = [[UIAlertView alloc] initWithTitle: @"No Stored Times"
											   message: @"There are no recorded times."
											  delegate: self
									 cancelButtonTitle: @"Close"
									 otherButtonTitles: nil];
		
	}
	
	
	
	[showTimes show];
}

- (NSMutableString *) getPuzzleTime {
	
	NSMutableString *s = [[NSMutableString alloc] init];
	
	[s setString: puzzleType];
	[s appendString: @" times"];
	
	return s;
}

- (IBAction) showSettings: (id) sender {
	
	SettingsMasterViewController *detailViewController = [[SettingsMasterViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
	
	navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentViewController: navController animated:YES completion: nil];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

	NSString *timesPath = [documentDirectory stringByAppendingPathComponent: @"times"];

	NSString *someString = [[NSString alloc] initWithData: [[NSFileManager defaultManager] contentsAtPath: timesPath] encoding: NSASCIIStringEncoding];
	NSLog(@"%@", someString);
	
	NSString *userDefaultsValuesPath =[[NSBundle mainBundle] pathForResource:@"appDefaults" 
																	  ofType:@"plist"];

	NSDictionary *userDefaultsValuesDict = [NSDictionary dictionaryWithContentsOfFile: userDefaultsValuesPath];

	// set them in the standard user defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults: userDefaultsValuesDict];

	if (![[NSUserDefaults standardUserDefaults] synchronize])
		NSLog(@"not successful in writing the default prefs");

	prefs = [NSUserDefaults standardUserDefaults];
	//[prefs removeObjectForKey: @"puzzleType"];
	
	cubeSize = [prefs integerForKey: @"cubeSize"];
	puzzleType = [prefs stringForKey: @"currentPuzzle"];
	inspection = [prefs boolForKey: @"inspection"];
	
	if (cubeSize <= 3) {
		viewScramble.hidden = YES;
	}
	
 	[UIApplication sharedApplication].statusBarHidden = YES;
	timerState = stopped;
	
	NSURL *beepSoundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"countdownBeep" ofType:@"wav"]];
	beepSound = [[AVAudioPlayer alloc] initWithContentsOfURL: beepSoundPath error: nil];
	
	[beepSound prepareToPlay];	
	
	NSURL *finalBeepPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"finalBeep" ofType:@"wav"]];
	finalBeep = [[AVAudioPlayer alloc] initWithContentsOfURL: finalBeepPath error: nil];
	
	[finalBeep prepareToPlay];
	
	[scrambleLbl setText: [self standardScramble]];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:) name:@"refreshView" object:nil];
	
	[super viewDidLoad];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

@end
