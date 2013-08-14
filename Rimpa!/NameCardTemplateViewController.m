//
//  NameCardTemplateViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/13.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "NameCardTemplateViewController.h"
#import "ABGridView.h"
#import <QuartzCore/QuartzCore.h>
#import "GalleryImages.h"

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
    //new gallerImages
    images = [GalleryImages new];
    
    
    
    //add abgridview
    [self.view addSubview:abGridView];
    [abGridView setDelegate:self];
    abGridView.itemSize = CGSizeMake(300, 150);
    abGridView.backgroundColor = [UIColor whiteColor];
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
    return [images.images count];
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
    item.image = images.images[index];
    item.layer.borderColor = [UIColor whiteColor].CGColor;
    item.layer.borderWidth = 3;
    
    return item;
}

- (void)gridView:(ABGridView *)gridView didSelectItemInGridView:(UIView *)view
{
//    PhotoViewController *photoView = [PhotoViewController new];
//    photoView.image = ((UIImageView *)view).image;
//    [self.navigationController pushViewController:photoView animated:YES];
}


@end
