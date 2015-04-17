//
//  ViewController.m
//  EITest
//
//  Created by JAVIER CALATRAVA LLAVERIA on 17/04/15.
//  Copyright (c) 2015 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

#import "ViewController.h"
#import "RemoteDataManager.h"
#import "ItemTVC.h"
#import "Item.h"
#import "EGORefreshTableHeaderView.h"
#import "Utils.h"
#import "ItemDetailVC.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>{
    
    __weak IBOutlet UITableView *tbvItemList;
     UIView *vewLoadingItems;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL _reloading;
    
    NSArray *arrData;
    
}

@end

@implementation ViewController

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self setupIUControls];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)showAlertNoData {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Localized(@"Alert")
                                                    message:Localized(@"AlertNoData")
                                                   delegate:self
                                          cancelButtonTitle:Localized(@"Ok")
                                          otherButtonTitles:nil, nil];
    [alert show];
}

-(void) setupIUControls{
    
    [self setupUITableRefreshHeaderView];
    
    [self showLoadingIndicator];
    
    arrData=[[NSArray alloc]init];
    tbvItemList.dataSource=self;
    tbvItemList.delegate=self;
    
    [[RemoteDataManager sharedInstance] getListItemsWithCompletion:^(ListItems *aListItems){

        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoadingIndicator];
            
            arrData = aListItems.arrItems;
            [tbvItemList reloadData];
            
            if([arrData count]==0){
                [self showAlertNoData];
            }
        });

    }];
}

- (void)setupUITableRefreshHeaderView {
    refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tbvItemList.bounds.size.height, tbvItemList.frame.size.width, tbvItemList.bounds.size.height)];
    refreshHeaderView.delegate = self;
    [refreshHeaderView refreshLastUpdatedDate];
    [tbvItemList addSubview:refreshHeaderView];
}


- (void)showLoadingIndicator {
    CGRect f = self.view.frame;
    f.size.height = self.view.frame.size.height-f.origin.y;
    f.size.width =  self.view.frame.size.width;
    if(vewLoadingItems)
    {
        [vewLoadingItems removeFromSuperview];
        vewLoadingItems = nil;
    }
    
    vewLoadingItems = [[UIView alloc] initWithFrame:f];
    vewLoadingItems.backgroundColor = [UIColor whiteColor];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.color  = [UIColor blackColor];
    indicator.center = CGPointMake(f.size.width/2, f.size.height/2);
    [indicator startAnimating];
    
    
    [vewLoadingItems addSubview:indicator];
    [self.view addSubview:vewLoadingItems];
}

- (void)hideLoadingIndicator {
    if(vewLoadingItems)
    {
        [vewLoadingItems removeFromSuperview];
        vewLoadingItems = nil;
    }
}


#pragma mark -  IBAction


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(arrData){
        return [arrData count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *sCellIdentifier = @"ItemTVCId";
    ItemTVC *cell = [tableView dequeueReusableCellWithIdentifier:sCellIdentifier];
    if (cell == nil) {
        cell = [[ItemTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sCellIdentifier];
    }
    
    if(indexPath.row<[arrData count]){
        Item *aItem = arrData[indexPath.row];
        [cell setItem:aItem];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     ItemDetailVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"ItemDetailStId"];
    
    if(indexPath.row<[arrData count]){
        vc.aItem =arrData[indexPath.row];
    }
    
     [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    return 65;
}
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    _reloading=YES;

    
    [[RemoteDataManager sharedInstance] getListItemsWithCompletion:^(ListItems *aListItems){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            arrData = aListItems.arrItems;
            _reloading=NO;
            [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tbvItemList];
            if([arrData count]>0){
                [tbvItemList reloadData];
            }
        });
        
    }];
    
    
    
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (void)egoTableHeaderState:(EGOPullRefreshState)aState{
    
}



@end
