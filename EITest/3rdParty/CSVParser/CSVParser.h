//
//  CSVParser.h
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVParser : NSObject

+ (CSVParser*)sharedInstance;

- (NSMutableArray *)loadAndParseWithStringData:(NSString*)stringData hasHeaderFields:(BOOL)hasHeaderFields;

@end
