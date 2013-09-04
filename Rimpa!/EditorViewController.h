//
//  EditorViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordLabel.h"
#import "SPUserResizableView.h"
#import "ALRadialMenu.h"

@interface EditorViewController : UIViewController <WordLabelDelegate,UITableViewDataSource,UITableViewDelegate,SPUserResizableViewDelegate,UIGestureRecognizerDelegate,ALRadialMenuDelegate,UITextViewDelegate>
{
    SPUserResizableView *currentlyEditingView;
    SPUserResizableView *lastEditedView;

}
//-(void)moveLabelToPoint:(CGPoint)currentPoint;

//- (void)checkTapTime:(NSTimer *)timer;

- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UIButton *boxButton;

@property (strong, nonatomic) ALRadialMenu *textMenu;
@property (strong, nonatomic) ALRadialMenu *boxMenu;

@property (strong, nonatomic) NSArray *popups;

@property (nonatomic,strong) UIImage *backgroundImage;



- (void)hiddenTableView:(UITableView *)tableView;
@end
