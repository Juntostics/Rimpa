//
//  DataForSaving.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/12.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataForSaving : NSObject<NSCoding>

@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *filepath;
@property (nonatomic, strong) NSDate *pubDate;
@property (nonatomic,strong) NSArray *labelList;
@property (nonatomic,strong) NSArray *boxList;
@property (nonatomic,strong) NSString *photoName;
@property(nonatomic,strong)UIImage *product;

-(id)initWithMakingData:(NSString *)photoName label:(NSArray *)labelList box:(NSArray *)boxList product:(UIImage *)product;
@end
