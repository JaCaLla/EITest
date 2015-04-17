//
//  RemoteDataManager.h
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItems.h"

typedef void (^getListItemsResult)(ListItems* aListItems);

@interface RemoteDataManager : NSObject

+ (RemoteDataManager*)sharedInstance;

- (void)getListItemsWithCompletion:(getListItemsResult)completion;


@end
