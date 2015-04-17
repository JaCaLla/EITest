//
//  Item.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "Item.h"
#import "UIImageView+AFNetworking.h"

#define WORDS_TOKEN_SEPARATOR     @","

#define NAME_IN_TEXT_ORDER        0
#define DESCRIPTION_IN_TEXT_ORDER 1


@implementation Item


-(id) initWithTitle:(NSString*)title
        description:(NSString*)description
           imageURL:(NSString*)imageURL{
    self = [super init];
    if(self){
        self.sTitle=title;
        self.sDescription=description;
        
        NSURL *aImageURL = [NSURL URLWithString:imageURL];
        self.imvImage = [[UIImageView alloc]init];
        [self.imvImage setImageWithURL:aImageURL
                      placeholderImage:[UIImage imageNamed:@"default_profile"]];
        
    }
    return self;
}


@end
