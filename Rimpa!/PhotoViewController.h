//
//  PhotoViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"

@interface PhotoViewController : UIViewController<ALRadialMenuDelegate>
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) ALRadialMenu *shareMenu;

@property (strong, nonatomic) NSArray *popups;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSNumber *index;
@end
