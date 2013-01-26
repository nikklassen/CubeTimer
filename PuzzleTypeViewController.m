//
//  PuzzleTypeViewController.m
//  CubeTimer
//
//  Created by Nik on 11-06-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PuzzleTypeViewController.h"
#import "CubeTimerViewController.h"
#import "SettingsMasterViewController.h"

NSMutableArray	*puzzles = nil;
NSArray			*stackStyle = nil;

@implementation PuzzleTypeViewController

@synthesize newPuzzleName, data;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	self.title = @"Puzzle/Stacking Style List";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	puzzles = [[NSMutableArray alloc] init];
	[puzzles addObjectsFromArray: [prefs objectForKey: @"puzzleTypes"]];
	stackStyle = @[@"3-3-3", @"3-6-3", @"Cycle"];
	
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray: @[@"Add new puzzle", puzzles, stackStyle]];
	
    [super viewDidLoad];
}

 - (void)viewWillAppear:(BOOL)animated {
	 
	 [super viewWillAppear:animated];
	 [self.tableView reloadData];
 }

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
    return data.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0)
		return 1;
	else
		return [[data objectAtIndex: section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	switch (section) {
		case 0:
			return @"";
			break;
		case 1:
			return @"Puzzles";
			break;
		default:
			return @"Speed Stacking";
			break;
	}

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Configure the cell...
	if (indexPath.section == 0) {
		cell.textLabel.text = @"Add new puzzle";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		
		if ([[[data objectAtIndex: indexPath.section] objectAtIndex: indexPath.row] isEqualToString: puzzleType]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			currentPuzzle = indexPath;
			puzzleType = [[data objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
		} else
			cell.accessoryType = UITableViewCellAccessoryNone;
		
		cell.textLabel.text = [[data objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
	}
	
	return cell;
	
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
	 if ((indexPath.section == 0 && indexPath.row <= 8) || indexPath.section == data.count) {
		 return NO;
	 } else
		 return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		[puzzles removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.		
    }   
}

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
	
	// Navigation logic may go here. Create and push another view controller.
	NewPuzzleViewController *detailViewController = [[NewPuzzleViewController alloc] initWithNibName: nil bundle:nil];

	switch (indexPath.section) {
		case 0:
			// Pass the selected object to the new view controller.
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
			break;
			
		default:
			if (indexPath != currentPuzzle) {
				[self.tableView cellForRowAtIndexPath: currentPuzzle].accessoryType = UITableViewCellAccessoryNone;
				currentPuzzle = indexPath;
				
				selectedPuzzle = [self.tableView cellForRowAtIndexPath: currentPuzzle].textLabel.text;
				if (indexPath.section == 1 && indexPath.row < 6) {
					// If it's a standard puzzle set the newPuzzleID to it's size
					newPuzzleID = indexPath.row + 2;
				} else if (indexPath.section == 1 && indexPath.row == 7) {
					// If it's set to megaminx set it to a special indicator
					newPuzzleID = 0;
				} else {
					// Anything else has no scramble so set it to -1
					newPuzzleID = -1;
				}

				
				[self.tableView cellForRowAtIndexPath: indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
				[[self.tableView cellForRowAtIndexPath: indexPath] setSelected: NO animated: YES];
			}
			[detailViewController release];
			break;
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
	
	[newPuzzleName release];
	[data release];
    [super dealloc];
}


@end

