//
//  LandingPageController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "LandingPageController.h"
#import "GalleryViewController.h"
#import "ChooseTypeViewController.h"

@interface LandingPageController ()
{
    IBOutlet UIButton *buttonGallery;
    IBOutlet UIButton *buttonChooseType;
}

@end

@implementation LandingPageController

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
    [super viewDidLoad];
    UIImage *backgroundimage = [UIImage imageNamed:@"washi2.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundimage];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveToGallery
{
    GalleryViewController *galleryViewController = [GalleryViewController new];
    [self.navigationController pushViewController:galleryViewController animated:YES];
}

-(void)moveToChooseType
{
    ChooseTypeViewController *chooseTypeController =
        [ChooseTypeViewController new];
    [self.navigationController pushViewController:chooseTypeController animated:YES];
}

-(IBAction)pushGallery:(id)sender{
    [self moveToGallery];
}

-(IBAction)pushChooseType:(id)sender{
    [self moveToChooseType];
}
@end
