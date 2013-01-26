//
//  NewPuzzleViewController.h
//  CubeTimer
//
//  Created by Nik on 11-07-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextfieldCell.h"

@class PuzzleTypeViewController;

@interface NewPuzzleViewController : UIViewController {

	TextfieldCell *cell;
	
}

@property (nonatomic, retain) TextfieldCell *cell;

- (void) submit;
@end
