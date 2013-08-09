//
//  ViewUtils.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "ViewUtils.h"

@implementation ViewUtils

-(IBAction)drawImage:(id)sender imageView:(NSString*)imageName
{
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:imageName];
}

@end
