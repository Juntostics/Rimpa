//
//  UserData.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataForSaving.h"

@interface UserData : NSObject
{
    NSMutableArray* _userDataList;
}

@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic, readonly) NSArray *userDataList; // 参照のときはMutableでないもの
@property(nonatomic,strong)NSNumber *galleryImageCount;

+ (UserData *)shareUserData;

- (void)addData:(DataForSaving *)data;
- (void)removeUserData:(NSUInteger)index;

// 永続化
- (void)load;
- (void)save;

@end
