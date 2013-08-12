//
//  WordLabel.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/06.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "WordLabel.h"

@implementation WordLabel

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
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
//    self.numberOfLines =0;
//    self.lineBreakMode = NO;
}

- (void)_init{
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
//    self.numberOfLines =0;
//    self.lineBreakMode = NO;

}

- (void)panAction : (UIPanGestureRecognizer *)sender
{
    [self.delegate panActionForLabel:sender];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate handleSingleTapForLabel:sender];
}
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    [self.delegate handleDoubleTapForLabel:sender];

}

-(void)forcusedNow
{
    self.backgroundColor = [UIColor redColor];
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

@end
