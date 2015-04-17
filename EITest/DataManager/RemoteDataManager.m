//
//  RemoteDataManager.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "RemoteDataManager.h"
#import "Item.h"
#import "CSVParser.h"

#define LINE_TOKEN_SEPARATOR     @"\n"

#define ITEM_LIST_URL  @"https://docs.google.com/spreadsheet/ccc?key=0Aqg9JQbnOwBwdEZFN2JKeldGZGFzUWVrNDBsczZxLUE&single=true&gid=0&output=csv"

#define TITLE_FIELD_NAME        @"title"
#define DESCRIPTION_FIELD_NAME  @"description"
#define IMAGE_FIELD_NAME        @"image"


typedef void (^getURLDataResult)(NSString* aData);

@implementation RemoteDataManager


+ (RemoteDataManager*)sharedInstance
{
    static RemoteDataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RemoteDataManager alloc] init];
        // Do any other initialisation stuff here
        
    });
    return sharedInstance;
}



- (void)getListItemsWithCompletion:(getListItemsResult)completion{
    
    [self getDataFromURL:ITEM_LIST_URL
              completion:^(NSString* aData){
                  
                  ListItems *aListItems = [[ListItems alloc]init];
                  
                  if([aData length]>0){
                      NSArray *arrTextLinesItem=[[CSVParser sharedInstance] loadAndParseWithStringData:aData hasHeaderFields:YES];
                      
                      if([arrTextLinesItem count]>0){
                          for(NSDictionary *dicFiedls in arrTextLinesItem){
                              [aListItems addItem:[[Item alloc] initWithTitle:dicFiedls[TITLE_FIELD_NAME]
                                                                  description:dicFiedls[DESCRIPTION_FIELD_NAME]
                                                                     imageURL:dicFiedls[IMAGE_FIELD_NAME]]];
                          }
                      }
                  }
  
                  if(completion){
                      completion(aListItems);
                  }
                  
              }];
}

-(void) getDataFromURL:(NSString*) aURL completion:(getURLDataResult)completion{
    
    NSURL *url = [NSURL URLWithString:aURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:[[NSOperationQueue alloc] init]
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error){
         
         NSString *sData=@"";
         if ([data length] >0 && error == nil)
         {
             sData = [NSString stringWithUTF8String:[data bytes]];
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil){
             NSLog(@"Error = %@", error);
         }
         
         if(completion){
             completion(sData);
         }
         
     }];
    
    /*
     NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:aURL]];
     NSURLResponse * response = nil;
     NSError * error = nil;
     NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
     returningResponse:&response
     error:&error];
     if (error == nil){
     // Parse data here
     NSLog(@"%@",[NSString stringWithUTF8String:[data bytes]]);
     return [NSString stringWithUTF8String:[data bytes]];
     }else{
     return nil;
     }
     */
}




@end
