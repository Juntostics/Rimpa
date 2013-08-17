//
//  TemporaryProductViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/08.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "TemporaryProductViewController.h"

@interface TemporaryProductViewController ()
{
    IBOutlet UIImageView *imageView;
}

@end

@implementation TemporaryProductViewController

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
    imageView.image = _image;
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.width);
    NSLog(@"%f,%f",imageView.image.size.width,imageView.image.size.height);
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
