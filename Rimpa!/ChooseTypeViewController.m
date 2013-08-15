//
//  ChooseTypeViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "ChooseTypeViewController.h"
#import "ChooseBackgroundViewController.h"
#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "RearViewController.h"
#import "NameCardTemplateViewController.h"

@interface ChooseTypeViewController ()<SWRevealViewControllerDelegate>
{
    IBOutlet UIButton *buttonNext;
}

@property (strong, nonatomic) SWRevealViewController *viewController;

@end

@implementation ChooseTypeViewController

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
-(IBAction)pushToChooseBackground:(id)sender
{
//    ChooseBackgroundViewController *chooseBackgroundViewController = [ChooseBackgroundViewController new];
//    [self.navigationController pushViewController:chooseBackgroundViewController animated:YES];
    
    FrontViewController *frontViewController = [[FrontViewController alloc] init];
	RearViewController *rearViewController = [[RearViewController alloc] init];
    
	
	UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
	
	SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
//    revealController.navigationController.navigationBarHidden = YES;
//    frontViewController.navigationController.navigationBarHidden = YES;
//    rearViewController.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    revealController.delegate = self;
    
    
    //revealController.bounceBackOnOverdraw=NO;
    //revealController.stableDragOnOverdraw=YES;
    
//	self.viewController = revealController;
    
       

	
    [self.navigationController pushViewController:revealController animated:YES];    
    }

@end
