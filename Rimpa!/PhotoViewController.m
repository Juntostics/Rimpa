//
//  PhotoViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
{
    IBOutlet UIImageView *imageView;
}

@end

@implementation PhotoViewController

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
    imageView.image = _image;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
