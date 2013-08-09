//
//  ChooseBackgroundViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "ChooseBackgroundViewController.h"
#import "EditorViewController.h"

@interface ChooseBackgroundViewController ()
{
    IBOutlet UIButton *buttonGo;
}
@end

@implementation ChooseBackgroundViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)pushToEditor:(id)sender
{
    EditorViewController *editorViewController = [EditorViewController new];
    [self.navigationController pushViewController:editorViewController animated:YES];
}

@end
