//
//  PhotoViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "PhotoViewController.h"
#import <Social/Social.h>
#import "UserData.h"
#import "GLDemoViewController.h"

@interface PhotoViewController ()
{
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *deleteButton;
    
}

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if (_index < [UserData shareUserData].galleryImageCount) {
        deleteButton.hidden = YES;
    }
    imageView.image = _image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// LINE
-(IBAction)postLine:(id)sender {
    // この例ではUIImageクラスの_resultImageを送る
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithUniqueName];
    [pasteboard setData:UIImagePNGRepresentation(_image) forPasteboardType:@"public.png"];
    
    // pasteboardを使ってパスを生成
    NSString *LineUrlString = [NSString stringWithFormat:@"line://msg/image/%@",pasteboard.name];
    
    // URLスキームを使ってLINEを起動
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];
}
// Facebook
- (IBAction)postFacebook:(id)sender {
    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    NSString* postContent = [NSString stringWithFormat:@"test"];
    [facebookPostVC setInitialText:postContent];
    //[facebookPostVC addURL:[NSURL URLWithString:@""]]; // URL文字列
    [facebookPostVC addImage:_image]; // 画像名（文字列）
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}


- (IBAction)deleteImagesAndMoveToGallery:(id)sender
{
    GLDemoViewController *gvc = (GLDemoViewController*)[self.navigationController.viewControllers objectAtIndex:0];
    gvc.deleteNum = _index;
    gvc.haveAThingToDelete = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)moveToEdit:(id)sender
{
    
}
@end