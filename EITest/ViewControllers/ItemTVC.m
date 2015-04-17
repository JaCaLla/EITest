//
//  ItemTVC.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ItemTVC.h"

@implementation ItemTVC{
    
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UILabel *lblDescription;
    __weak IBOutlet UIImageView *imvImage;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setItem:(Item*)aItem{
    
    lblName.text = aItem.sTitle;
    lblDescription.text = aItem.sDescription;
    imvImage.image = aItem.imvImage.image;
    
    
}

@end
