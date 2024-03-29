//
//  VerticalPosterViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/15.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "VerticalPosterViewController.h"
#import "GalleryImages.h"
#import "ABGridView.h"
#import "UserData.h"
#import "PhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "EditorViewController.h"

@interface VerticalPosterViewController ()<ABGridViewDelegate>
{
    IBOutlet ABGridView *abGridView;
    GalleryImages *images;
    
}

@end

@implementation VerticalPosterViewController

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"4-light-menu-bar"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"choose background image  (press one to edit)";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background4.jpeg"]];


    //new galleryimages
    images = [GalleryImages new];
    
    //set bacgroundcolor on view
    //UIImage *backgroundimage = [UIImage imageNamed:@"rinpa9.jpg"];
    
    //add abgridview
    [self.view addSubview:abGridView];
    [abGridView setDelegate:self];
    abGridView.itemSize = CGSizeMake(150, 300);
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
    return [images.verticalPosterImages count];
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
    item.image = images.verticalPosterImages[index];
    item.layer.borderColor = [UIColor whiteColor].CGColor;
    item.layer.borderWidth = 3;
    
    return item;
}

- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
    //    PhotoViewController *photoView = [PhotoViewController new];
    //    photoView.image = ((UIImageView *)view).image;
    //    [self.navigationController pushViewController:photoView animated:YES];
    
    EditorViewController *editor = [EditorViewController new];
    editor.backgroundImage = ((UIImageView *)view).image;
    [self.navigationController pushViewController:editor animated:YES];
    
}

@end

