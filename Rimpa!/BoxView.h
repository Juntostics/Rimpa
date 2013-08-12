//
//  BoxView.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/11.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoxViewDelegate;


@interface BoxView : UIView
-(void)forcusedNow;
-(void)releasedNow;
@property (nonatomic,assign)id<BoxViewDelegate> delegate;
@end


@protocol BoxViewDelegate <NSObject>

- (void)panActionForBox : (UIPanGestureRecognizer *)sender;
- (void)handleSingleTapForBox :(UITapGestureRecognizer *)sender;
- (void)handleDoubleTapForBox :(UITapGestureRecognizer *)sender;


- (void)resizeConrolViewDidBeginResizing:(BoxView *)boxView;
-(void)resizeConrolViewDidResize:(BoxView *)boxView;
-(void)resizeConrolViewDidEndResizing:(BoxView *)boxView;
@end