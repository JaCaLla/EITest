//
//  ItemDetailVC.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ItemDetailVC.h"

@interface ItemDetailVC (){
    
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblDescription;
    __weak IBOutlet UIImageView *imvImage;
}

@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUIControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUIControls{
    self.title = self.aItem.sTitle;
    lblTitle.text = self.aItem.sTitle;
    lblDescription.text = self.aItem.sDescription;
    imvImage.image = self.aItem.imvImage.image;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
