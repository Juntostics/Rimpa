//
//  GalleryViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "GalleryViewController.h"
#import "ABGridView.h"
#import "UserData.h"
#import "PhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
@interface GalleryViewController ()<ABGridViewDelegate>
{
    IBOutlet ABGridView *abGridView;
}

@end

@implementation GalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.userInteractionEnabled=YES;

    if(_haveAThingToDelete){
        [[UserData shareUserData] removeUserData:[_deleteNum integerValue]];
        NSLog(@"datacount:%lu",(unsigned long)[[UserData shareUserData].userDataList count]);
        [abGridView reloadData];
        [[UserData shareUserData] save];
    }
    _haveAThingToDelete = NO;

}

- (void)viewDidLoad
{
    self.title = @"Gallery";
    //userinteractionをonにする
  
    
    //delete data
    if(_haveAThingToDelete){
        [[UserData shareUserData] removeUserData:[_deleteNum integerValue]];
        NSLog(@"datacount:%lu",(unsigned long)[[UserData shareUserData].userDataList count]);
        [abGridView reloadData];
        [[UserData shareUserData] save];

    }
    _haveAThingToDelete = NO;
    
  

    //set bacgroundcolor on view
    //UIImage *backgroundimage = [UIImage imageNamed:@"rinpa9.jpg"];
   
    //add abgridview
    [self.view addSubview:abGridView];
    [abGridView setDelegate:self];
    abGridView.itemSize = CGSizeMake(300, 150);
    //abGridView.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    [abGridView reloadData];
    [super viewDidLoad];
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInGridView:(ABGridView *)gridView;
{
    return [[UserData shareUserData].images count];
}
-(UIView *)viewForItemInGridView:(ABGridView *)gridView atIndex:(NSInteger)index
{
    return [self viewForItemInGridViewAtImageView:gridView atIndex:index];
}

- (UIView *)viewForItemInGridViewAtImageView:(ABGridView *)gridView atIndex:(NSInteger)index
{
    UIImageView* item = ( UIImageView* )[gridView dequeueReusableItem];
    if( item == nil )
    {
        item = [UIImageView new];
    }
    item.image = [UserData shareUserData].images[index];
    item.layer.borderColor = [UIColor whiteColor].CGColor;
    item.layer.borderWidth =1;
    
    return item;
}

- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
    PhotoViewController *photoView = [PhotoViewController new];
    photoView.image = ((UIImageView *)view).image;
    
    
    
    [self.navigationController pushViewController:photoView animated:YES];
}




@end
