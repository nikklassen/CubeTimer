//
//  SettingsMasterViewController.m
//  CubeTimer
//
//  Created by Nik on 11-06-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsMasterViewController.h"
#import "CubeTimerViewController.h"
#import "PuzzleTypeViewController.h"

NSString	*selectedPuzzle = nil;
int			newPuzzleID = 0;

@implementation SettingsMasterViewController

@synthesize inspectionSwitch, dataList;
//@synthesize delegate;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	self.title = @"Settings";
	dataList = [[NSMutableArray alloc] initWithObjects:@"Inspection", @"Puzzle Type", nil];
    [super viewDidLoad];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
																   style: UIBarButtonItemStyleDone
																  target:self
																  action:@selector(saveSettings)];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
																				  target: self
																				  action: @selector (returnToTimer)];
	
	[[self navigationItem] setLeftBarButtonItem: cancelButton];
	[[self navigationItem] setRightBarButtonItem: saveButton];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) saveSettings {
	
	// Update CubeTimer variables
	if ([inspectionSwitch isOn])
		inspection = YES;
	else {
		inspection = NO;
	}
	
	puzzleType = selectedPuzzle;
	cubeSize = newPuzzleID;	
	
	// Update prefs with new UserDefaults
	[prefs setBool: inspection forKey: @"inspection"];
	
	// Refresh list of puzzles with any new custom puzzles
	[prefs setObject: puzzles forKey: @"puzzleTypes"];
	
	// Set the selected puzzle as the current puzzle
	[prefs setObject: selectedPuzzle forKey: @"currentPuzzle"];
	[prefs setObject: [NSNumber numberWithInt: cubeSize] forKey: @"cubeSize"];
	
	[prefs synchronize];
	
	// Update other variables	
	if (cubeSize <= 3) {
		viewScramble.hidden = YES;
	}
	
	//[scrambleLbl setText: [self standardScramble]];
	
	//[temp release];
	
	//[self.delegate settingsMasterViewController: self didSaveSettings: YES];
	
	//[self.parentViewController standardScramble];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
	
	[self.parentViewController dismissViewControllerAnimated: YES completion: nil];
}

- (void) returnToTimer {
	
	// Revert to the "current" puzzle type if changes were made
	// puzzleType = [prefs stringForKey: @"currentPuzzle"];
	
	[self.parentViewController dismissViewControllerAnimated: YES completion: nil];
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0)
		return 1;
	else
		return [dataList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	switch (indexPath.section) {
		case 0:
			
			cell.textLabel.text = @"View previous times";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			break;			
		case 1:
			
			cell.textLabel.text = [dataList objectAtIndex: indexPath.row];
			
			switch (indexPath.row) {
				case 0:
					
					inspectionSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
					cell.accessoryView = inspectionSwitch;
					
					if (inspection)
						[inspectionSwitch setOn: YES];
					
					break;
				case 1:
					
					cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
					break;
				default:
					break;
			}
			
			break;
		default:
			break;
	}	
	
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (indexPath.section == 0) {
		
		PuzzleTimeViewController *detailViewController = [[PuzzleTimeViewController alloc] initWithStyle: UITableViewStyleGrouped];
		
		[self.navigationController pushViewController: detailViewController animated: YES];
		
	} else if (indexPath.section == 1 && indexPath.row == 1) {
		
		PuzzleTypeViewController *detailViewController = [[PuzzleTypeViewController alloc] initWithStyle: UITableViewStyleGrouped];
		
		[self.navigationController pushViewController: detailViewController animated: YES];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

