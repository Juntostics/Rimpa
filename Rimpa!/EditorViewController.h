//
//  EditorViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordLabel.h"

@interface EditorViewController : UIViewController <WordLabelDelegate,UITableViewDataSource,UITableViewDelegate>
-(void)moveLabelToPoint:(CGPoint)currentPoint;

- (void)checkTapTime:(NSTimer *)timer;

@end
