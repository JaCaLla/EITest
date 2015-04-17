//
//  ListItems.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ListItems.h"

@implementation ListItems{
   
}

-(id) init{
    self = [super init];
    if(self){
        _arrItems=[[NSMutableArray alloc]init];
    }
    return self;
}


-(void) addItem:(Item*)aItem{
    [_arrItems addObject:aItem];
}


@end
