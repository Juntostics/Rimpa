//
//  GLCell.h
//  GLGooglePlusLayout
//
//  Created by Gautam Lodhiya on 21/04/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLCell : UICollectionViewCell
- (void)setDisplayImage:(UIImage *)image;

@property (nonatomic, copy) NSString *displayString;
@end
