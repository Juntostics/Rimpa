//
//  GalleryImages.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/08.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "GalleryImages.h"
@interface GalleryImages()
{
    
}
@end

@implementation GalleryImages

- (id)init{
    self = [super init];
    if(self){
        [self _init];
    }
    return self;
}
- (void)_init
{
    _images = [NSArray arrayWithObjects:[UIImage imageNamed:@"rinpa2.jpg"],
               [UIImage imageNamed:@"rinpa3.jpg"],[UIImage imageNamed:@"rinpa4.jpg"],
               [UIImage imageNamed:@"rinpa5.jpg"],[UIImage imageNamed:@"rinpa6.jpg"],
               [UIImage imageNamed:@"rinpa7.jpg"],[UIImage imageNamed:@"rinpa8.jpg"],
               [UIImage imageNamed:@"rinpa9.jpg"],[UIImage imageNamed:@"rinpa10.jpg"],
               [UIImage imageNamed:@"rinpa11.jpg"],[UIImage imageNamed:@"rinpa12.jpg"],
               [UIImage imageNamed:@"rinpa13.jpg"],[UIImage imageNamed:@"rinpa14.jpg"],
               [UIImage imageNamed:@"rinpa15.jpg"],[UIImage imageNamed:@"rinpa16.jpg"],
               nil];
}
@end
