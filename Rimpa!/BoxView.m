//
//  BoxView.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/11.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "BoxView.h"
@interface BoxView ()
@property (nonatomic, readwrite) CGPoint translation;
@property (nonatomic) CGPoint startPoint;

@end




@implementation BoxView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}


- (id)init{
    self = [super init];
    if(self){
        [self _init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self _init];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedAction:)];
    //    [self addGestureRecognizer:tapGesture];
    
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:gestureRecognizer];

    
    
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    //tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:doubleTapGestureRecognizer];
    //
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    [singleTapGestureRecognizer requireGestureRecognizerToFail: doubleTapGestureRecognizer];
    //tapGestureRecognizer.delegate = self;
    
    [self addGestureRecognizer:singleTapGestureRecognizer];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)] ;
    [self addGestureRecognizer:pan];
    self.backgroundColor = [UIColor grayColor];
    self.userInteractionEnabled = YES;
    //    self.numberOfLines =0;
    //    self.lineBreakMode = NO;
}

- (void)_init{
    self.backgroundColor = [UIColor grayColor];
    self.userInteractionEnabled = YES;
    //    self.numberOfLines =0;
    //    self.lineBreakMode = NO;
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint translationInView = [gestureRecognizer translationInView:self.superview];
        self.startPoint = CGPointMake(roundf(translationInView.x), translationInView.y);
        
        if ([self.delegate respondsToSelector:@selector(resizeConrolViewDidBeginResizing:)]) {
            [self.delegate resizeConrolViewDidBeginResizing:self];
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:self.superview];
        self.translation = CGPointMake(roundf(self.startPoint.x + translation.x),
                                       roundf(self.startPoint.y + translation.y));
        
        if ([self.delegate respondsToSelector:@selector(resizeConrolViewDidResize:)]) {
            [self.delegate resizeConrolViewDidResize:self];
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if ([self.delegate respondsToSelector:@selector(resizeConrolViewDidEndResizing:)]) {
            [self.delegate resizeConrolViewDidEndResizing:self];
        }
    }
}



- (void)panAction : (UIPanGestureRecognizer *)sender
{
    [self.delegate panActionForBox:sender];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate handleSingleTapForBox:sender];
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate handleDoubleTapForBox:sender];
    
}

-(void)forcusedNow
{
    self.backgroundColor = [UIColor yellowColor];
}

-(void)releasedNow
{
    [self setBackgroundColor:[UIColor blueColor]];
    self.backgroundColor = [UIColor clearColor];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
