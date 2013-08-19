//
//  UserData.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataForSaving.h"
#import "GalleryImages.h"

@interface UserData : NSObject
{
    NSMutableArray* _userDataList;
}

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic, readonly) NSArray *userDataList; // 参照のときはMutableでないもの
@property(nonatomic,strong)NSNumber *galleryImageCount;
@property(nonatomic,strong)GalleryImages  *galleryImages;


+ (UserData *)shareUserData;

- (void)addData:(DataForSaving *)data;
- (void)removeUserData:(NSUInteger)index;

// 永続化
- (void)load;
- (void)save;

@end
