//
//  UserData.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property (nonatomic,strong) NSMutableArray *images;

+ (UserData *)shareUserData;

-(void) addData:(UIImage*)img;

@end
