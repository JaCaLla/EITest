//
//  ListItems.h
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ListItems : NSObject

@property (strong)  NSMutableArray *arrItems;


-(void) addItem:(Item*)aItem;

@end
