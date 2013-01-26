//
//  NewPuzzleViewController.m
//  CubeTimer
//
//  Created by Nik on 11-07-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewPuzzleViewController.h"
#import "PuzzleTypeViewController.h"

@implementation NewPuzzleViewController

@synthesize cell;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	self.title = @"Add New Puzzle";
	
	UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
																		  target: self
																		  action: @selector(submit)];
	done.title = @"Submit";
	
	self.navigationItem.rightBarButtonItem = done;
	[done release];
							  
	
    [super viewDidLoad];
}

- (void) submit {
	
	[puzzles addObject: cell.newInput.text];
	
	[self.navigationController popViewControllerAnimated: YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"textfieldCell";
    
    cell = (TextfieldCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	
    if (cell == nil) {
		
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed: @"TextfieldCell" owner:nil options:nil];
		for (id currentObject in nibObjects) {
			if ([currentObject isKindOfClass: [UITableViewCell class]]) {
				cell = (TextfieldCell *)currentObject;
				break;
			}
		}
    }
	
	return cell;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
