//
//  GalleryViewController.h
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"

@interface GalleryViewController : UIViewController
{
}
@property (nonatomic) BOOL haveAThingToDelete;
@property (nonatomic,strong) NSNumber* deleteNum;
@property (nonatomic,strong) UIView* maskView;
@end
