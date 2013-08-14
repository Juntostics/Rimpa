//
//  DataForSaving.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/12.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "DataForSaving.h"

#define PHOTONAMEKEY @"photoName"
#define LABELKEY @"labelList"
#define BOXKEY @"boxList"
#define PUBDATEKEY @"pubDate"
#define PRODUCTKEY @"product"

@implementation DataForSaving

- (id)init {
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(id)initWithMakingData:(NSString *)photoName label:(NSArray *)labelList box:(NSArray *)boxList product:(UIImage *)product{
    self = [super init];
    if(self){
        _photoName = photoName;
        _labelList = labelList;
        _boxList = boxList;
        _pubDate = [NSDate date];
        _product = product;
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // インスタンス変数をデコードする
    _photoName = [decoder decodeObjectForKey:PHOTONAMEKEY];
    _labelList = [decoder decodeObjectForKey:LABELKEY];
    _boxList = [decoder decodeObjectForKey:BOXKEY];
    _product = [decoder decodeObjectForKey:PRODUCTKEY];
    _pubDate = [decoder decodeObjectForKey:PUBDATEKEY];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    // インスタンス変数をエンコードする
    [encoder encodeObject:_photoName forKey:PHOTONAMEKEY];
    [encoder encodeObject:_labelList forKey:LABELKEY];
    [encoder encodeObject:_boxList forKey:BOXKEY];
    [encoder encodeObject:_product forKey:PRODUCTKEY];
    [encoder encodeObject:_pubDate forKey:PUBDATEKEY];
}

@end
