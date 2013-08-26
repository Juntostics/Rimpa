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
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoViewController ()
{
    IBOutlet UIImageView *imageView;
    BOOL deleteButtonIsExist;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"4-light-menu-bar"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"save/share/delete";
    NSLog(@"%@,%d,%d,%c",_index,[[UserData shareUserData].userDataList count],[[UserData shareUserData].images count],deleteButtonIsExist);
    
    if ([[UserData shareUserData].galleryImages.images containsObject:_image]) {
        deleteButtonIsExist = NO;
    }else{
        deleteButtonIsExist = YES;
    }
    //ALradiusボタンの初期化
    //create an instance of the radial menu and set ourselves as the delegate.
	self.shareMenu = [[ALRadialMenu alloc] init];
    self.shareMenu.startRadius = 180;
	self.shareMenu.delegate = self;
    
    imageView.image = _image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background4.jpeg"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ALRadiusボタン
- (IBAction)buttonPressed:(id)sender {
	//the button that brings the items into view was pressed
	if (sender == self.shareButton) {
		[self.shareMenu buttonsWillAnimateFromButton:sender withFrame:self.shareButton.frame inView:self.view];
	}
}


#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	//FIXME: dipshit, change one of these variable names
	if (radialMenu == self.shareMenu && deleteButtonIsExist) {
		return 4;
	} else {
        return 3;
    }
	
	return 0;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.shareMenu) {
		return 180;
	}
	return 0;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.shareMenu) {
		return 80;
	}
	
	return 0;
}


- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
	if (radialMenu == self.shareMenu) {
		if (index == 1) {
			return [UIImage imageNamed:@"facebook500.png"];
		} else if (index == 2) {
			return [UIImage imageNamed:@"twitter.png"];
		} else if (index == 3) {
			return [UIImage imageNamed:@"saveicon2.png"];
		} else if (deleteButtonIsExist && index == 4) {
			return [UIImage imageNamed:@"deleteicon.png"];
		}
        
	} 	
	return nil;
}


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
	if (radialMenu == self.shareMenu) {
        //		[self.textMenu itemsWillDisapearIntoButton:self.textButton];
        if (index == 1) {
            //facebook
            [self postFacebook:nil];
        } else if (index == 2) {
            [self postToTwitter];
		} else if (index == 3) {
            //save image to photo library
            [self saveImageToPhotosAlbum:_image];
        } else if (deleteButtonIsExist && index == 4) {
            //delete
            [self deleteImagesAndMoveToGallery:nil];
        }
        
	}    
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

// 写真へのアクセスが許可されている場合はYESを返す。まだ許可するか選択されていない場合はYESを返す。
- (BOOL)isPhotoAccessEnableWithIsShowAlert:(BOOL)_isShowAlert {
    // このアプリの写真への認証状態を取得する
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    BOOL isAuthorization = NO;
    
    switch (status) {
        case ALAuthorizationStatusAuthorized: // 写真へのアクセスが許可されている
            isAuthorization = YES;
            break;
        case ALAuthorizationStatusNotDetermined: // 写真へのアクセスを許可するか選択されていない
            isAuthorization = YES; // 許可されるかわからないがYESにしておく
            break;
        case ALAuthorizationStatusRestricted: // 設定 > 一般 > 機能制限で利用が制限されている
        {
            isAuthorization = NO;
            if (_isShowAlert) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"エラー"
                                          message:@"写真へのアクセスが許可されていません。\n設定 > 一般 > 機能制限で許可してください。"
                                          delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
            
        case ALAuthorizationStatusDenied: // 設定 > プライバシー > 写真で利用が制限されている
        {
            isAuthorization = NO;
            if (_isShowAlert) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"エラー"
                                          message:@"写真へのアクセスが許可されていません。\n設定 > プライバシー > 写真で許可してください。"
                                          delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
            
        default:
            break;
    }
    return isAuthorization;
}

- (void)saveImageToPhotosAlbum:(UIImage*)image {
    
    BOOL isPhotoAccessEnable = [self isPhotoAccessEnableWithIsShowAlert:YES];
    
    /////// フォトアルバムに保存 ///////
    if (isPhotoAccessEnable) {
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:image.CGImage
                                  orientation:(ALAssetOrientation)image.imageOrientation
                              completionBlock:
         ^(NSURL *assetURL, NSError *error){
             NSLog(@"URL:%@", assetURL);
             NSLog(@"error:%@", error);
             
             ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
             
             if (status == ALAuthorizationStatusDenied) {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"エラー"
                                           message:@"写真へのアクセスが許可されていません。\n設定 > 一般 > 機能制限で許可してください。"
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                 [alertView show];
             } else {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@""
                                           message:@"フォトアルバムへ保存しました。"
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                 [alertView show];
             }
         }];        
    }
}

// Twitterに投稿
- (void)postToTwitter {
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:@"via Think Big Act Local"];
    [vc addImage:_image];
//    [vc addURL:[NSURL URLWithString:@"http://himaratsu.hatenablog.com/"]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)moveToEdit:(id)sender
{
    
}
@end