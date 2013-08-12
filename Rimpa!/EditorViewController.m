//
//  EditorViewController.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/05.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "EditorViewController.h"
#import "ViewUtils.h"
#import "WordLabel.h"
#import "BoxView.h"
#import "TemporaryProductViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserData.h"
#import "SPUserResizableView.h"



@interface EditorViewController ()
{
    IBOutlet UIImageView *imageView;
    IBOutlet UITextView *textView;
    IBOutlet UITableView *tableView;
    IBOutlet UITableView *colorTableView;
    NSMutableArray *labelList;
    NSMutableArray *boxList;
    NSInteger initialPositionForLabel;
    NSInteger initialPositionForBox;
    CGPoint  touchPoint;
    WordLabel *touchedLabel;
    NSDate *touchDate;
    NSTimer *tapTimer;
    NSArray *fontFamilyNames;
    NSArray *colors;
    CGRect defaultTableViewFrame;
    UIImage *image;
    UserData *userData;
    
}

@end

@implementation EditorViewController

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section{
    if (tableView1.tag==0) {
        return [fontFamilyNames count];
    }else{
        return [colors count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if(tableView1.tag ==0){
        NSString *fontfamilyname = [fontFamilyNames objectAtIndex:indexPath.row];
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontfamilyname];
        cell.textLabel.text = fontfamilyname;
        cell.textLabel.font = [UIFont fontWithName:fontNames.lastObject size:15];
        return cell;
    }else{
        //cell.textLabel.text = [[colors objectAtIndex:indexPath.row] description];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView1 willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView1.tag==1) {
        cell.backgroundColor = [colors objectAtIndex:indexPath.row];
    }

}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView1 cellForRowAtIndexPath:indexPath];
    if(tableView1.tag ==0){
        NSArray *fontNames = [UIFont fontNamesForFamilyName:cell.textLabel.text];
        touchedLabel.font = [UIFont fontWithName:fontNames.lastObject size:touchedLabel.font.pointSize];
        [self slideTableViewToleft:tableView1];
    }else{
        touchedLabel.textColor = [colors objectAtIndex:indexPath.row];
        [self slideTableViewToRight:tableView1];
    }
}

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
    //SPuser用テスト
    CGRect gripFrame = CGRectMake(50, 50, 200, 150);
    SPUserResizableView *userResizableView = [[SPUserResizableView alloc] initWithFrame:gripFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:gripFrame];
    [contentView setBackgroundColor:[UIColor redColor]];
    userResizableView.contentView = contentView;
    userResizableView.delegate = self;
    [userResizableView showEditingHandles];
    currentlyEditingView = userResizableView;
    lastEditedView = userResizableView;
    [self.view addSubview:userResizableView];

    
    
    //ボックスからフォーカスを外すためのパンジェスチャー
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditingHandles)];
    [gestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:gestureRecognizer];

    
    
    
    //UserDataのSingletonをゲット
    userData = [UserData shareUserData];

    //color配列の初期化
    colors =
    [NSArray arrayWithObjects:[UIColor blackColor],[UIColor blueColor],
     [UIColor brownColor],[UIColor clearColor],[UIColor cyanColor],
     [UIColor darkGrayColor],[UIColor grayColor],[UIColor greenColor],
     [UIColor lightGrayColor],[UIColor magentaColor],[UIColor orangeColor],
     [UIColor purpleColor],[UIColor redColor],[UIColor whiteColor],
     [UIColor yellowColor], nil];
    
    //fontの配列を取得
    fontFamilyNames = [UIFont familyNames];
    //tableViewの初期化
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    //colorTableViewの初期化
    colorTableView.delegate = self;
    colorTableView.dataSource = self;
    [self.view addSubview:colorTableView];
    //tableViewの初期位置をゲット
    defaultTableViewFrame = tableView.frame;
    //テーブルビューを初期位置に移動させる
    [self slideTableViewToleft:tableView];
    [self slideTableViewToRight:colorTableView];
    
    //wordLabelを入れる配列を生成
    labelList = [NSMutableArray array];
    initialPositionForLabel =0;
    
    //背景のボックスとなるboxViewを入れる配列を生成
    boxList = [NSMutableArray array];
    initialPositionForBox = 0;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self generateLabel:nil];
    [textView setAlpha:0];
    [textView setBackgroundColor:[UIColor clearColor]];
    
    
    //ーーーーーーーーーtextfieldの設定
    UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    accessoryView.backgroundColor = [UIColor whiteColor];
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"閉じる" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    textView.inputAccessoryView = accessoryView;
    //----------------------------
    
    
    //    NSString *familyName;
//    for(familyName in familyNames){
//        NSLog(@"---  family name: %@", familyName);
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        NSString *fontName;
//        for(fontName in fontNames){
//            NSLog(@"  font name: %@", fontName);
//        }
//    }

}
-(void)closeKeyboard:(id)sender{
    [textView resignFirstResponder];
    [textView setAlpha:0];
    [touchedLabel setText:textView.text];
    NSLog(@"%@",touchedLabel);
    for (WordLabel *label in labelList) {
        [label setAlpha:1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)drawImageView:(id)sender
{    
    // UIImageを指定した生成例
    imageView.image = [UIImage imageNamed:@"rinpa2.jpg"];
    NSLog(@"%f,%f",imageView.image.size.width,imageView.image.size.height);
    
}
-(IBAction)generateLabel:(id)sender
{
    
    WordLabel *label = [WordLabel new];
    label.frame = CGRectMake(100+initialPositionForLabel, 100+initialPositionForLabel, 100, 50);
    label.text = @"input text.";
    [labelList addObject:label];
    [imageView addSubview:label];
    initialPositionForLabel += 25;
    label.delegate = self;
}

-(IBAction)generateBox:(id)sender
{
    BoxView *boxView = [BoxView new];
    boxView.frame =  CGRectMake(200+initialPositionForLabel, 200+initialPositionForLabel, 300, 100);
    [boxList addObject:boxView];
    [imageView addSubview:boxView];
    initialPositionForBox += 25;
    boxView.delegate = self;
}

-(IBAction)beLager:(id)sender{
    UIFont *font = touchedLabel.font;
    touchedLabel.font = [font fontWithSize:font.pointSize + 2];
    [touchedLabel sizeToFit];
}

-(IBAction)beSmaller:(id)sender{
    UIFont *font = touchedLabel.font;
    touchedLabel.font = [font fontWithSize:font.pointSize - 2];
    [touchedLabel sizeToFit];
}


//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    // タッチされた座標を取得
//    touchPoint = [[touches anyObject] locationInView:self.view];
//                NSLog(@"touchesBegan");
//
//    
//    for (id obj in labelList) {
//        // AgendaCircleかどうかの判別
//        WordLabel *label = (WordLabel *)obj;
//        NSLog(@"%f,%f,%f,%f,%f,%f",touchPoint.x,touchPoint.y,label.frame.origin.x,label.frame.origin.y,label.frame.origin.x+label.frame.size.width,label.frame.origin.y+label.frame.size.height);
//        
//        if(touchPoint.x-label.frame.origin.x >=0 && touchPoint.y-label.frame.origin.y>=0&& label.frame.origin.x+label.frame.size.width-touchPoint.x>=0&&label.frame.origin.y+label.frame.size.height - touchPoint.y>=0)
//        {
//            // タッチされたcircleを指定
//            touchedLabel = label;
//            // タッチされた時刻を指定
//            touchDate = [NSDate date];
//            // タッチ時間にタイマーを設定
//            tapTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(checkTapTime:) userInfo:nil repeats:NO];
//            
//            
//            // タッチされたCircleを全面に表示
//            [self.view bringSubviewToFront:touchedLabel];
//            [touchedLabel forcusedNow];
//        }
//        
//    }
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"hi");
//    // 移動中の座標
//    CGPoint pt = [[touches anyObject] locationInView:self.view];
//    
//    // 移動距離
//    CGFloat dist = sqrt((touchPoint.x-pt.x)*(touchPoint.x-pt.x) + (touchPoint.y-pt.y)*(touchPoint.y-pt.y));
//    
//    // Circleをタッチしたとき
//    if (touchedLabel) {
//        // 少しでも移動していたとき、Circleを動かす
//        if (dist > 0) {
//            [self moveLabelToPoint:pt];
//        }
//        
//        // タイマーは無効化
//        [tapTimer invalidate]; // stop timer
//        tapTimer = nil;
//    }
//}
//
//-(void)moveLabelToPoint:(CGPoint)currentPoint
//{
//    CGRect rect = touchedLabel.frame;
//    rect.origin.x = currentPoint.x;
//    rect.origin.y = currentPoint.y;
//    touchedLabel.frame = rect;
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    // Circleがタッチされたとき
//    if (touchedLabel) {
//        // シングルタップ
//    }
//    
//    // Circle以外がタッチされたとき
//
//    // タッチ関連の変数を空にする
//    touchedLabel = nil;
//    touchDate = nil;
//    [tapTimer invalidate]; // stop timer
//    tapTimer = nil;
//}
//
//// 一定時間後にこのメソッドが呼ばれたら、長押しと判断する
//- (void)checkTapTime:(NSTimer *)timer
//{
//
//}

- (void)panActionForLabel : (UIPanGestureRecognizer *)sender
{
    CGPoint p = [sender translationInView:self.view];
	
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
	
    // ドラッグで移動した距離を初期化する
    // これを行わないと、[sender translationInView:]が返す距離は、ドラッグが始まってからの蓄積値となるため、
    // 今回のようなドラッグに合わせてImageを動かしたい場合には、蓄積値をゼロにする
    [sender setTranslation:CGPointZero inView:self.view];

}

- (void) panActionForBox:(UIPanGestureRecognizer *)sender
{
    CGPoint p = [sender translationInView:self.view];
	
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
	
    // ドラッグで移動した距離を初期化する
    // これを行わないと、[sender translationInView:]が返す距離は、ドラッグが始まってからの蓄積値となるため、
    // 今回のようなドラッグに合わせてImageを動かしたい場合には、蓄積値をゼロにする
    [sender setTranslation:CGPointZero inView:self.view];
}

- (void)handleSingleTapForLabel:(UITapGestureRecognizer *)sender
{
    touchedLabel = nil;

    for(WordLabel *label in labelList){
        [label releasedNow];
    }
    
    touchedLabel = (WordLabel *)sender.view;
    [touchedLabel forcusedNow];
}

-(void)handleSingleTapForBox:(UITapGestureRecognizer *)sender
{
    
}

- (void)handleDoubleTapForLabel:(UITapGestureRecognizer *)sender
{
    
    touchedLabel = nil;
    
    for(WordLabel *label in labelList){
        [label releasedNow];
    }
    
    touchedLabel = (WordLabel *)sender.view;
    [touchedLabel forcusedNow];
    
    
    //入力モードにするためtextfield以外を消して,labelのテキストをtextfieldを出現させる
    [textView becomeFirstResponder];
    [textView setText:touchedLabel.text];
    [textView setAlpha:1];
    for (WordLabel *label in labelList) {
        [label setAlpha:0];
    }
}

- (void)handleDoubleTapForBox:(UITapGestureRecognizer *)sender
{
    
}

-(IBAction)slideToRightFontBar:(id)sender{
    [self slideTableViewToRight:tableView];
}

-(IBAction)slideToLeftFontBar:(id)sender
{
    [self slideTableViewToleft:colorTableView];
}

-(void)slideTableViewToRight:(UITableView*)tbView
{
    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect temprect = tableView.frame;
        temprect.origin.x = tbView.frame.origin.x + defaultTableViewFrame.size.width;
        tbView.frame = temprect;
    }];
}

-(void)slideTableViewToleft:(UITableView*)tbView
{
    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect temprect = tableView.frame;
        temprect.origin.x = tbView.frame.origin.x - defaultTableViewFrame.size.width;
        tbView.frame = temprect;
    }];
}

-(IBAction)saveImage:(id)sender
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *bitmap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    TemporaryProductViewController *temporaryViewController =  [TemporaryProductViewController new];
    temporaryViewController.image = bitmap;
    [userData addData:bitmap];
    [self.navigationController pushViewController:temporaryViewController animated:YES];
}

-(IBAction)deleteLabel:(id)sender
{
    
    [labelList removeObject:touchedLabel];
    [touchedLabel removeFromSuperview];
    touchedLabel = nil;
}


- (void)userResizableViewDidBeginEditing:(SPUserResizableView *)userResizableView {
    [currentlyEditingView hideEditingHandles];
    currentlyEditingView = userResizableView;
}

- (void)userResizableViewDidEndEditing:(SPUserResizableView *)userResizableView {
    lastEditedView = userResizableView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([currentlyEditingView hitTest:[touch locationInView:currentlyEditingView] withEvent:nil]) {
        return NO;
    }
    return YES;
}

- (void)hideEditingHandles {
    // We only want the gesture recognizer to end the editing session on the last
    // edited view. We wouldn't want to dismiss an editing session in progress.
    [lastEditedView hideEditingHandles];
}





@end
