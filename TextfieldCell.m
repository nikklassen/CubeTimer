//
//  TextfieldCell.m
//  CubeTimer
//
//  Created by Nik on 11-07-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TextfieldCell.h"


@implementation TextfieldCell

@synthesize prompt, newInput;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		[prompt setText: @"Puzzle Name:"];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
