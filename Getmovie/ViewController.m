//
//  ViewController.m
//  Getmovie
//
//  Created by 谢鹏 on 2017/3/29.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AlAsetvideo.h"
#import <AVFoundation/AVFoundation.h>
#define kWidthOfScreen self.view.bounds.size.width
#define kHeightOfScreen self.view.bounds.size.height-30
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *mutarray;
@property(nonatomic,strong)NSMutableArray *arraymovies;
@property(nonatomic,strong)UITableView *mytableview1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedcontrol;
@property (weak, nonatomic) IBOutlet UIScrollView *myscollview;
//@property(strong,nonatomic)AlAsetvideo *alvideo;
@property(nonatomic,strong)UITableView *mytableview2;
@end

@implementation ViewController
#pragma init
-(NSMutableArray*)arraymovies{
    if (!_arraymovies) {
        _arraymovies=[NSMutableArray array];
    }
    return _arraymovies;
}
-(NSMutableArray*)mutarray{
    if (!_mutarray) {
        _mutarray=[NSMutableArray array];
    }
    return _mutarray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.mytableview1) {
        NSLog(@"..%lu",self.arraymovies.count);
        return self.arraymovies.count;
    }
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mycell=@"mycell";
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
    }
    if (tableView==self.mytableview1) {
        AlAsetvideo *viedome=[[AlAsetvideo alloc]init];
        for (viedome in self.arraymovies ) {
            
            NSData *decodedImageData   = [[NSData alloc] initWithBase64Encoding:viedome.image];
            UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
            cell.imageView.image=decodedImage;
            cell.textLabel.text=viedome.url;
            //cell.detailTextLabel.text=viedome.url;
            //NSLog(@"...%@",cell.imageView.image);
        }
        NSLog(@"...3");
        return cell;
    }
    cell.imageView.image=[UIImage imageNamed:@"1.jpg"];
    cell.textLabel.text=@"456";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.mytableview1) {
        AlAsetvideo *asetvieo=self.arraymovies[indexPath.row];
        NSString *urlStr = @"http://7xawdc.com2.z0.glb.qiniucdn.com/o_19p6vdmi9148s16fs1ptehbm1vd59.mp4";
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:urlStr];
        NSURL *url2=  [[NSBundle mainBundle]URLForResource:@"1.mp4" withExtension:nil];
        MPMoviePlayerController *play= [[MPMoviePlayerController alloc]initWithContentURL:url1];
          play.view.frame =CGRectMake(0,0, kWidthOfScreen,kWidthOfScreen * (9.0 /16.0));
        [self.view addSubview:play.view];
        //play.movieSourceType = MPMovieSourceTypeFile;// 播放本地视频时需要这句
        //    self.player.controlStyle = MPMovieControlStyleNone;// 不需要进度条
        play.shouldAutoplay = YES;// 是否自动播放（默认为YES）
        play.scalingMode=MPMovieScalingModeAspectFill;
        play.controlStyle=MPMovieControlStyleDefault;
        [play prepareToPlay];
        [play play];
        NSLog(@"12345666");
        
       // [play addObserver:self forKeyPath:@"MPMoviePlayerPlaybackDidFinishNotification" options:<#(NSKeyValueObservingOptions)#> context:<#(nullable void *)#>]
      
//        NSURL *url1=  [[NSBundle mainBundle]URLForResource:@"1.mp4" withExtension:nil];
        NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
        NSURL *url = [NSURL URLWithString:playString];
//        //设置播放的项目
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
      
//        //初始化player对象
        AVPlayer *player = [[AVPlayer alloc] initWithURL:url1];
        //设置播放页面
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
        layer.videoGravity
//        //设置播放页面的大小
//        layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
//        layer.backgroundColor = [UIColor cyanColor].CGColor;
//        //设置播放窗口和当前视图之间的比例显示内容
//        layer.videoGravity = AVLayerVideoGravityResizeAspect;
//        //添加播放视图到self.view
//        [self.view.layer addSublayer:layer];
//        [player play];
//        //设置播放进度的默认值
//        //self.progressSlider.value = 0;
//        //设置播放的默认音量值
//        player.volume = 1.0f;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.myscollview.contentOffset.x==0) {
        self.selectedcontrol.selectedSegmentIndex=0;
    }
    else if (self.myscollview.contentOffset.x==kWidthOfScreen){
        self.selectedcontrol.selectedSegmentIndex=1;

    }
}
#pragma action
- (IBAction)selectedaction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0) {
        self.myscollview.contentOffset=CGPointMake(0, 0);
        
    }
    else{
        self.myscollview.contentOffset=CGPointMake(kWidthOfScreen, 0);
    }
    
}
-(void)getmovies{
//    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
//    // 获取当前应用对照片的访问授权状态
//    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
//    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
//    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
//        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
//        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
//        // 展示提示语
//    }
    __weak typeof(self) weakself=self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        ALAssetsLibraryGroupsEnumerationResultsBlock listBlock=^(ALAssetsGroup *group ,BOOL *stop){
//            if (group != nil) {
//                [weakself.mutarray addObject:group];
//            }else{
//                [weakself.mutarray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    [obj enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL  *stop) {
//                        if ([result thumbnail] != nil) {
//                            // 照片
//                            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
//                                
//                                
//                                //NSLog(@"读取到照片了");
//                            }
//                            // 视频
//                            else if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo] ){
//                                NSLog(@"..video...zai na l");
//                                
//                                NSURL *url = [[result defaultRepresentation] url];
//                                AlAsetvideo *alvideo=[[AlAsetvideo alloc]init];
//                                alvideo.url=[url absoluteString];
//                                UIImage *image=[UIImage imageWithCGImage:[result thumbnail]];
//                                NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//                                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//                                
//                            
//                                alvideo.image=encodedImageStr;
//                                NSLog(@"..%@url..",alvideo.url);
//                                NSLog(@"..%@iamge..",alvideo.image);
//                                
//                                alvideo.duration=[result valueForProperty:ALAssetPropertyDuration];
//                                NSLog(@"..%@duration..",alvideo.duration);
//                                [weakself.arraymovies addObject:alvideo];
//                                NSLog(@"--%lu movies--",(unsigned long)weakself.arraymovies.count);
//                                
//                            }
//                        }
//                    }];
//                }];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakself.mytableview1 reloadData];
//            });
//
//            }
//            
//        };
//        
//      
//        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]  init];
//        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
//                                     usingBlock:listBlock failureBlock:nil];
//        });
        ALAssetsLibrary *library1 = [[ALAssetsLibrary alloc] init];
        [library1 enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [group setAssetsFilter:[ALAssetsFilter allVideos]];
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    
                    if (result) {
                        NSURL *url = [[result defaultRepresentation] url];
                        AlAsetvideo *alvideo=[[AlAsetvideo alloc]init];
                        alvideo.url=[url absoluteString];
                        UIImage *image=[UIImage imageWithCGImage:[result thumbnail]];
                        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
                        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                        
                        
                        alvideo.image=encodedImageStr;
                        NSLog(@"..%@url..",alvideo.url);
                        //NSLog(@"^^%@iamge^^",alvideo.image);
                        
                        alvideo.duration=[result valueForProperty:ALAssetPropertyDuration];
                        NSLog(@"**%@duration**",alvideo.duration);
                        [weakself.arraymovies addObject:alvideo];                    }
                }];
            } else {
                //没有更多的group时，即可认为已经加载完成。
               // NSLog(@"after load, the total alumvideo count is %ld",_albumVideoInfos.count);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.mytableview1 reloadData ];
                });
            }
            
        } failureBlock:^(NSError *error) {
            //NSLog(@"Failed.");
        }];
    }
     
            
        
 
    


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myscollview.contentSize=CGSizeMake(kWidthOfScreen*2, 0);
    self.myscollview.contentOffset=CGPointMake(0, 0);
    self.myscollview.pagingEnabled=YES;
    self.myscollview.delegate=self;
    AFURLSessionManager *url=[[AFURLSessionManager alloc]init];
    //self.alvideo=[[AlAsetvideo alloc]init];
    [self getmovies];
    self.mytableview1=[[UITableView alloc]initWithFrame:CGRectMake(0,5, kWidthOfScreen, kHeightOfScreen) style:UITableViewStylePlain];
  self.mytableview2=[[UITableView alloc]initWithFrame:CGRectMake(kWidthOfScreen, 5, kWidthOfScreen, kHeightOfScreen) style:UITableViewStylePlain];
    self.mytableview1.delegate=self;
    self.mytableview1.dataSource=self;
    self.mytableview2.delegate=self;
    self.mytableview2.dataSource=self;
    CGRect rect=[UIScreen mainScreen].bounds ;
    NSLog(@"$$%f..%f",rect.size.width,rect.size.height);
    NSLog(@"%f...%f",self.view.bounds.size.width,self.view.bounds.size.height);
    NSLog(@"%f...%f",self.view.frame.size.width,self.view.frame.size.height);
    [ALAssetsFilter allPhotos];
    [self.myscollview addSubview:self.mytableview1];
    [self.myscollview addSubview:self.mytableview2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)moviePlayerPlaybackDidFinishNotification:(NSNotification *)noti{
    NSInteger movieFinishKey = [noti.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    
    //2. 根据状态不同来自行填写逻辑代码
    switch (movieFinishKey) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放结束");
            
            // 进行视频切换 需要两步
            
            //1. 要想换视频, 就需要更换地址
//            self.mpc.contentURL = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
//            [self.mpc play];
            break;
            
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"播放错误");
            break;
            
        case MPMovieFinishReasonUserExited:
            NSLog(@"退出播放");
            
            // 如果是不带view的播放器, 那么播放完毕(退出/错误/结束)都应该退出
            //[self.mpc.view removeFromSuperview];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
