//
//  ChooseTypeViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"

@interface ChooseTypeViewController : UIViewController
-(IBAction)pushToChooseBackground:(id)sender;
@property (nonatomic,strong)UserData *userData;


@end
