//
//  NameCardTemplateViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/13.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "NameCardTemplateViewController.h"
#import "GalleryImages.h"
#import "ABGridView.h"
#import "UserData.h"
#import "PhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
#import "EditorViewController.h"
#import "ChooseTypeViewController.h"

@interface NameCardTemplateViewController ()<ABGridViewDelegate>
{
    IBOutlet ABGridView *abGridView;
    GalleryImages *images;
    
}

@end

@implementation NameCardTemplateViewController

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
    
    //add abgridview
    [self.view addSubview:abGridView];
    [abGridView setDelegate:self];
    abGridView.itemSize = CGSizeMake(300, 150);
    abGridView.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    [abGridView reloadData];
    [super viewDidLoad];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [self.navigationController.navigationBar addGestureRecognizer:revealController.panGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *backbtn =
    [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemReply // スタイルを指定
     target:self  // デリゲートのターゲットを指定
     action:@selector(moveBack:)  // ボタンが押されたときに呼ばれるメソッドを指定
     ];
    
    self.navigationItem.rightBarButtonItem = backbtn;
    

    
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