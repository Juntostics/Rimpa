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

- (void)viewDidLoad
{
    
    //set bacgroundcolor on view
    UIImage *backgroundimage = [UIImage imageNamed:@"washi2.jpg"];
    //get UserData by Singleton
    userData = [UserData shareUserData];
   
    //add abgridview
    [self.view addSubview:abGridView];
    [abGridView setDelegate:self];
    abGridView.itemSize = CGSizeMake(300, 150);
    abGridView.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    [abGridView reloadData];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInGridView:(ABGridView *)gridView;
{
    return [userData.images count];
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
    item.image = userData.images[index];
    item.layer.borderColor = [UIColor whiteColor].CGColor;
    item.layer.borderWidth = 3;
    
    return item;
}

- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
    PhotoViewController *photoView = [PhotoViewController new];
    photoView.image = ((UIImageView *)view).image;
    [self.navigationController pushViewController:photoView animated:YES];
}




@end
