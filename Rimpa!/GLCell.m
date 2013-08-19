//
//  GLCell.m
//  GLGooglePlusLayout
//
//  Created by Gautam Lodhiya on 21/04/13.
//  Copyright (c) 2013 Gautam Lodhiya. All rights reserved.
//

#import "GLCell.h"

@interface GLCell()
@property (nonatomic, strong) UIImageView *displayImageView;
@end

@implementation GLCell

#pragma mark - Accessors
- (UIImageView *)displayImageView
{
    if (!_displayImageView) {
        _displayImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _displayImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //_displayLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rinpa27.jpg"]];
        _displayImageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _displayImageView;
}


- (void)setDisplayImage:(UIImage *)image
{
    _displayImageView.image = image;
}

#pragma mark - Life Cycle
- (void)dealloc
{
    [_displayImageView removeFromSuperview];
    _displayImageView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper05.jpg"]];
        [self.contentView addSubview:self.displayImageView];
    }
    return self;
}

@end
