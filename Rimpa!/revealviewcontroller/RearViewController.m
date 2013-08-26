
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
*/

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "NameCardTemplateViewController.h"
#import "HorizontalPosterViewController.h"
#import "VerticalPosterViewController.h"
#import "GalleryViewController.h"
#import "GLDemoViewController.h"

@interface RearViewController()

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"4-light-menu-bar"] forBarMetrics:UIBarMetricsDefault];
    
	[super viewDidLoad];
//    [_rearTableView setBackgroundView:nil];
//    [_rearTableView setBackgroundColor:[UIColor blackColor]];
    
    //tableviewの背景を画像に変更
//    self.rearTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rinpa9.jpg"]];
	
	self.title = NSLocalizedString(@"Menu", nil);
}


#pragma marl - UITableView Data Source

//セクションの数の設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//セクションのタイトルを設定
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    
    //第１セクションの設定
    if (section==0) {
        return @"taka a look at rinpa card";
    }
    
    //第２セクションの設定
    else if (section==1) {
        return @"make new Rinpa Card";
    }
    
    return nil;
}

//テーブルのセル数の設定
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    //第１セクションの設定
    if (section==0) {
        return 1;
    }
    
    //第２セクションの設定
    else if (section==1) {
        return 3;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
    
	if(indexPath.section==0){
        if(row == 0)
        {
            cell.textLabel.text = @"Gallery";
        }
    }else{
    if (row == 0)
	{
		cell.textLabel.text = @"Name Card";
	}
	else if (row == 1)
	{
		cell.textLabel.text = @"Horizontal Poster";
	}
	else if (row == 2)
	{
		cell.textLabel.text = @"Vertical Poster";
	}
    }
    cell.textLabel.textColor =[UIColor grayColor];

	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // We know the frontViewController is a NavigationController
    UINavigationController *frontNavigationController = (id)revealController.frontViewController;  // <-- we know it is a NavigationController
    NSInteger row = indexPath.row;

	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	
    
	// ... and the second row (=1) corresponds to the "MapViewController".
    if(indexPath.section==0)
    {
        if (row == 0)
        {
            
            // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
            if ( ![frontNavigationController.topViewController isKindOfClass:[GLDemoViewController class]] )
            {
                GLDemoViewController* viewController = [[GLDemoViewController alloc] initWithNibName:nil bundle:nil];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
                [revealController setFrontViewController:navigationController animated:YES];
            }
            
            // Seems the user attempts to 'switch' to exactly the same controller he came from!
            else
            {
                [revealController revealToggle:self];
            }
        }
    }
    else{
    if (row == 0)
	{
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[NameCardTemplateViewController class]] )
        {
            NameCardTemplateViewController *name = [NameCardTemplateViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:name];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
	else if (row == 1)
	{
        
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[HorizontalPosterViewController class]] )
        {
            HorizontalPosterViewController *horizontal = [HorizontalPosterViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:horizontal];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
    
    
    }
	else if (row == 2)
	{
        
		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[VerticalPosterViewController class]] )
        {
            VerticalPosterViewController *vertical = [VerticalPosterViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vertical];
			[revealController setFrontViewController:navigationController animated:YES];
		}
        
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
			[revealController revealToggle:self];
		}
	}
    }
    
}


//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}

@end