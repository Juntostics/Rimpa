//
//  UserData.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "UserData.h"
#import "GalleryImages.h"

@interface UserData()
{
    GalleryImages *galleryImages;
}
@end


@implementation UserData

static UserData* _sharedInstance = nil;

+ (UserData *)shareUserData
{
    if(!_sharedInstance){
        _sharedInstance = [UserData new];
    }
    
    return _sharedInstance;
}

- (id)init{
    self = [super init];
    if(self){
        [self _init];
    }
    return self;
}
- (void)_init
{
    galleryImages = [GalleryImages new];
    _images = [NSMutableArray arrayWithArray:galleryImages.images];
}

-(void) addData:(UIImage*)img
{
    [_images addObject:img];
}

@end



