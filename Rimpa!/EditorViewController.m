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
#import "TemporaryProductViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserData.h"
#import "SPUserResizableView.h"
#import "ResizableBoxView.h"
#import "DataForSaving.h"



@interface EditorViewController ()
{
    IBOutlet UISlider *sliderForBoxAlpha;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextView *textView;
    IBOutlet UITableView *fontTableView;
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
    id nowForcusingOn;
    BOOL fontTableViewIsHidden;
    BOOL colorTableViewIsHidden;
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


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==1) {
        cell.backgroundColor = [colors objectAtIndex:indexPath.row];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(tableView.tag ==0){
        NSArray *fontNames = [UIFont fontNamesForFamilyName:cell.textLabel.text];
        touchedLabel.font = [UIFont fontWithName:fontNames.lastObject size:touchedLabel.font.pointSize];
        [self forcusingLabel:touchedLabel];
        [touchedLabel sizeToFit];
//        [self slideTableViewToleft:tableView];
//        fontTableViewIsHidden=YES;
    }else{
        touchedLabel.textColor = [colors objectAtIndex:indexPath.row];
        [self forcusingLabel:touchedLabel];
//        [self slideTableViewToRight:tableView];
//        colorTableViewIsHidden=YES;
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
    //背景のロード
    imageView.image = _backgroundImage;
    //アスペクト比を保ちつつ最大の大きさで表示
    imageView.contentMode=UIViewContentModeScaleAspectFit;

    //boxアルファを変更するためのスライダーの設定
    sliderForBoxAlpha.minimumValue = 0;
    sliderForBoxAlpha.maximumValue = 1;
    sliderForBoxAlpha.value = 0.5;
    
    // スライドしている最中に値を調べられるようにする．
    // デフォルトでYESだがサンプルのため
    sliderForBoxAlpha.continuous = YES;
    
    // スライダーの値が変更されたときに呼ばれるメソッドを設定
    [sliderForBoxAlpha addTarget:self
               action:@selector(slider_ValueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    //ボックスからフォーカスを外すためのパンジェスチャー
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideEditingHandles)];
    [gestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:gestureRecognizer];

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
    fontTableView.delegate = self;
    fontTableView.dataSource = self;
    fontTableView.allowsSelectionDuringEditing = YES;
    fontTableViewIsHidden = NO;
    //colorTableViewの初期化
    colorTableView.delegate = self;
    colorTableView.dataSource = self;
    colorTableView.allowsSelectionDuringEditing = YES;
    colorTableViewIsHidden = NO;
    
    [fontTableView reloadData];
    [colorTableView reloadData];
    //tableViewの初期位置をゲット
    defaultTableViewFrame = fontTableView.frame;
    
    //テーブルビューを初期位置に移動させる
    if (!fontTableViewIsHidden) {
        [self slideTableViewToleft:fontTableView];
        fontTableViewIsHidden=YES;
    }
    if (!colorTableViewIsHidden) {
        [self slideTableViewToRight:colorTableView];
        colorTableViewIsHidden=YES;
    }
    
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
    [closeButton setTitle:@"close" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    textView.inputAccessoryView = accessoryView;
    //---------------------------
}

- (void)slider_ValueChanged:(id)sender
{
    UISlider *slider = sender;
    currentlyEditingView.alpha = slider.value;
}


-(void)closeKeyboard:(id)sender{
    [textView resignFirstResponder];
    [textView setAlpha:0];
    [touchedLabel setText:textView.text];
    for (WordLabel *label in labelList) {
        [label setAlpha:1];
    }
    [self forcusingLabel:touchedLabel];
    [touchedLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)drawImageView:(id)sender
{    
    // UIImageを指定した生成例
    imageView.image = _backgroundImage;
    NSLog(@"%f,%f",imageView.image.size.width,imageView.image.size.height);
    
}
-(IBAction)generateLabel:(id)sender
{
    
    WordLabel *label = [WordLabel new];
    label.frame = CGRectMake(100+initialPositionForLabel, 100+initialPositionForLabel, 100, 50);
    label.text = @"input text.";
    [labelList addObject:label];
    [imageView addSubview:label];
    //[imageView bringSubviewToFront:label];
    initialPositionForLabel += 25;
    label.delegate = self;
    
}

-(IBAction)generateBox:(id)sender
{
    CGRect gripFrame = CGRectMake(50, 50, 200, 150);
    ResizableBoxView *userResizableView = [[ResizableBoxView alloc] initWithFrame:gripFrame];
    userResizableView.backgroundColor = [UIColor grayColor];
    UIView *contentView = [[UIView alloc] initWithFrame:gripFrame];
    [contentView setBackgroundColor:[UIColor clearColor]];
    userResizableView.contentView = contentView;
    userResizableView.delegate = self;
    [userResizableView showEditingHandles];
    userResizableView.alpha = 0.5;
    currentlyEditingView = userResizableView;
    lastEditedView = userResizableView;
    [imageView addSubview:userResizableView];
    [imageView sendSubviewToBack:userResizableView];
    
    [boxList addObject:userResizableView];
}

-(IBAction)beLager:(id)sender{
    UIFont *font = touchedLabel.font;
    touchedLabel.font = [font fontWithSize:font.pointSize + 2];
    [touchedLabel sizeToFit];
    [self forcusingLabel:touchedLabel];
}

-(IBAction)beSmaller:(id)sender{
    UIFont *font = touchedLabel.font;
    touchedLabel.font = [font fontWithSize:font.pointSize - 2];
    [touchedLabel sizeToFit];
    [self forcusingLabel:touchedLabel];
}


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
    [self forcusingLabel:(WordLabel*)sender.view];

}

- (void)handleSingleTapForLabel:(UITapGestureRecognizer *)sender
{
    [self releasingLabel:touchedLabel];
    for(WordLabel *label in labelList){
        [label releasedNow];
    }
    
    touchedLabel = (WordLabel *)sender.view;
    [self forcusingLabel:touchedLabel];
}

- (void)forcusingLabel:(WordLabel *)label
{
    touchedLabel = label;
    [label forcusedNow];
}

- (void)releasingLabel:(WordLabel *)label
{
    [label releasedNow];
    touchedLabel = nil;
}

- (void)handleDoubleTapForLabel:(UITapGestureRecognizer *)sender
{
    
    [self releasingLabel:touchedLabel];
    for(WordLabel *label in labelList){
        [label releasedNow];
    }
    touchedLabel = (WordLabel *)sender.view;
//
    //入力モードにするためtextfield以外を消して,labelのテキストをtextfieldを出現させる
    [textView becomeFirstResponder];
    [textView setText:touchedLabel.text];
    [textView setAlpha:1];
    for (WordLabel *label in labelList) {
        [label setAlpha:0];
    }
}

-(IBAction)slideToRightFontBar:(id)sender{
    if(fontTableViewIsHidden){
        [self slideTableViewToRight:fontTableView];
        fontTableViewIsHidden=NO;
    }
}

-(IBAction)slideToLeftColorBar:(id)sender
{
    if (colorTableViewIsHidden) {
    [self slideTableViewToleft:colorTableView];
        colorTableViewIsHidden=NO;
    }
}

-(void)slideTableViewToRight:(UITableView*)tbView
{
    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect temprect = fontTableView.frame;
        temprect.origin.x = tbView.frame.origin.x + defaultTableViewFrame.size.width;
        tbView.frame = temprect;
    }];
}

-(void)slideTableViewToleft:(UITableView*)tbView
{
    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect temprect = fontTableView.frame;
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
    
    //datファイルに保存する
    DataForSaving *data = [[DataForSaving alloc] initWithMakingData:@"rinpa2.jpg" label:labelList box:boxList product:bitmap];
    [[UserData shareUserData] addData:data];
    [[UserData shareUserData] save];
    NSLog(@"%d",[[UserData shareUserData].userDataList count]);

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
    
    //touchlabelを空にする
    [touchedLabel releasedNow];
    touchedLabel = NULL;
    
    //テーブルをなおす
    if (!fontTableViewIsHidden) {
        [self slideTableViewToleft:fontTableView];
        fontTableViewIsHidden=YES;
    }
    if (!colorTableViewIsHidden) {
        [self slideTableViewToRight:colorTableView];
        colorTableViewIsHidden=YES;
    }
}

-(IBAction)deleteBox:(id)sender{
    [boxList removeObject:currentlyEditingView];
    [currentlyEditingView removeFromSuperview];
    currentlyEditingView = lastEditedView;
}

@end
