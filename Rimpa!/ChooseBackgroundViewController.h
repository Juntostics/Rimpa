//
//  ChooseBackgroundViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "SWRevealViewController.h"

@interface ChooseBackgroundViewController : UIViewController<UIApplicationDelegate>
-(IBAction)pushToEditor:(id)sender;
@property (strong, nonatomic) SWRevealViewController *viewController;
@end
