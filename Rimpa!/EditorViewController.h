//
//  EditorViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordLabel.h"
#import "BoxView.h"
#import "SPUserResizableView.h"

@interface EditorViewController : UIViewController <WordLabelDelegate,UITableViewDataSource,UITableViewDelegate,SPUserResizableViewDelegate,UIGestureRecognizerDelegate>
{
    SPUserResizableView *currentlyEditingView;
    SPUserResizableView *lastEditedView;

}
//-(void)moveLabelToPoint:(CGPoint)currentPoint;

//- (void)checkTapTime:(NSTimer *)timer;
@property (nonatomic,strong) UIImage *backgroundImage;

@end
