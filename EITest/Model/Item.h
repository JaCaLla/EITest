//
//  Item.h
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImageView.h>

@interface Item : NSObject

@property (strong) NSString* sTitle;
@property (strong) NSString* sDescription;
@property (strong) UIImageView* imvImage;

-(id) initWithTitle:(NSString*)title
        description:(NSString*)description
           imageURL:(NSString*)imageURL;

@end
