//
//  UserData.m
//  Rimpa!
//
//  Created by pcuser on 2013/08/09.
//  Copyright (c) 2013年 pcuser. All rights reserved.
//

#import "UserData.h"
#import "GalleryImages.h"
#import "DataForSaving.h"

@interface UserData()
{
    GalleryImages *galleryImages;
    NSDictionary *userDataDictionary;
}
@end


@implementation UserData

@synthesize userDataList = _userDataList;


static UserData* _sharedInstance = nil;

+ (UserData *)shareUserData
{
    if(!_sharedInstance){
        _sharedInstance = [UserData new];
    }
    
    return _sharedInstance;
}

- (id)init{
    self = [super init];
    if(self){
        [self _init];
    }
    return self;
}
- (void)_init
{
    galleryImages = [GalleryImages new];
    _userDataList = [NSMutableArray array];
    _images = [NSMutableArray arrayWithArray:galleryImages.images];
    
}



//--------------------------------------------------------------//
#pragma mark -- userDataの操作 --
//--------------------------------------------------------------//
//-(void) addData:(UIImage*)img
//{
//    [_images addObject:img];
//}

- (void)addData:(DataForSaving *)data
{
    // 引数を確認する
    if (!data) {
        return;
    }
    
    // pdfを追加する
    [_userDataList addObject:data];
    [_images addObject:data.product];
}

- (void)insertData:(DataForSaving *)data atIndex:(unsigned int)index
{
    // 引数を確認する
    if (!data) {
        return;
    }
    // if (index < 0 || index > [_blogs count]) {
    if (index > [_userDataList count]) {
        return;
    }
    
    // pdfを挿入する
    [_userDataList insertObject:data atIndex:index];
}

- (void)moveUserDataAtIndex:(unsigned int)fromIndex toIndex:(unsigned int)toIndex
{
    // 引数を確認する
    // if (fromIndex < 0 || fromIndex > [_blogs count] - 1) {
    if (fromIndex > [_userDataList count] - 1) {
        return;
    }
    // if (toIndex < 0 || toIndex > [_blogs count]) {
    if (toIndex > [_userDataList count]) {
        return;
    }
    
    // pdfを移動する
    DataForSaving* data;
    data = [_userDataList objectAtIndex:fromIndex];
    [_userDataList removeObject:data];
    [_userDataList insertObject:data atIndex:toIndex];
}

- (void)removeUserData:(DataForSaving *)data {
    // 指定されたpdfを削除
    [_userDataList removeObject:data];
    
    // ファイル自体を削除する
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:data.filepath]) {
        [fileManager removeItemAtPath:data.filepath error:nil];
    }
}


//--------------------------------------------------------------//
#pragma mark -- 永続化 --
//--------------------------------------------------------------//

- (NSString*)_makeDir
{
    // ドキュメントパスを取得する
    NSArray*    paths;
    NSString*   path;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] < 1) {
        return nil;
    }
    path = [paths objectAtIndex:0];
    
    // .userDataディレクトリを作成する
    path = [path stringByAppendingPathComponent:@".userData"];
    return path;
}

- (NSString*)_makePath
{
    // blog.datパスを作成する
    NSString*   path;
    path = [[self _makeDir] stringByAppendingPathComponent:@"userData.dat"];
    return path;
}

- (void)load
{
    // ファイルパスを取得する
    NSString*   filePath;
    filePath = [self _makePath];
    if (!filePath || ![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return;
    }
    
    // チャンネルの配列を読み込む
    NSArray*  userDatas;
    userDatas = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!userDatas) {
        return;
    }
    
    // チャンネルの配列を設定する
    [_userDataList setArray:userDatas];
    for (DataForSaving *data in _userDataList) {
        [_images addObject:data.product];
    }
    
}

- (void)save
{
    // ファイルマネージャを取得する
    NSFileManager*  fileMgr;
    fileMgr = [NSFileManager defaultManager];
    
    // .blogディレクトリを作成する
    NSString*   dataDir;
    dataDir = [self _makeDir];
    if (![fileMgr fileExistsAtPath:dataDir]) {
        NSError* error;
        [fileMgr createDirectoryAtPath:dataDir
           withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    // チャンネルの配列を保存する
    NSString*   filePath;
    filePath = [self _makePath];
    NSLog(@"%@", filePath);
    [NSKeyedArchiver archiveRootObject:_userDataList toFile:filePath];
}


@end



