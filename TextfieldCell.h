//
//  TextfieldCell.h
//  CubeTimer
//
//  Created by Nik on 11-07-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextfieldCell : UITableViewCell {

	IBOutlet UILabel *prompt;
	IBOutlet UITextField *newInput;
	
}

@property (nonatomic, retain) UILabel *prompt;
@property (nonatomic, retain, getter = myNewInput) UITextField *newInput;

@end
