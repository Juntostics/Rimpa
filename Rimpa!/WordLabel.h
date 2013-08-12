//
//  WordLabel.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/06.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WordLabelDelegate;

@interface WordLabel : UILabel

-(void)forcusedNow;
-(void)releasedNow;
@property (nonatomic,assign)id<WordLabelDelegate> delegate;
@end

@protocol WordLabelDelegate <NSObject>

- (void)panActionForLabel : (UIPanGestureRecognizer *)sender;
- (void)handleSingleTapForLabel :(UITapGestureRecognizer *)sender;
- (void)handleDoubleTapForLabel :(UITapGestureRecognizer *)sender;


@end
