//
//  ViewController.m
//  CaptureVideo
//
//  Created by 何江浩 on 16/2/29.
//  Copyright © 2016年 何江浩. All rights reserved.
//

#import "ViewController.h"
#import "VideoTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerView.h"

#import "TLMoviePlayerController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) VideoPlayerView *playerView;

@property (nonatomic, strong) TLMoviePlayerController *moviePlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
    [_playBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBtn];
    
    
    _myView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 240, 240)];
    [_myView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_myView];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"IMG_1311" ofType:@"m4v"];
//    NSURL *url = [NSURL URLWithString:filePath];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerPlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
//    _playerView = [[VideoPlayerView alloc ]initWithFrame:CGRectMake(20, 100, 280,280)];
//    [self.view addSubview:_playerView];
    
//    [_playerView.coverView setBackgroundColor:[UIColor blackColor]];
//    VideoPlayerView *testVideo = [[VideoPlayerView alloc] initWithFrame:CGRectMake(20, 390, 80, 80)];
//    [self.view addSubview:testVideo];
    
    _moviePlayer = [[TLMoviePlayerController alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
    [_moviePlayer setContentURL:[NSURL URLWithString:@"http://203.166.162.84/video/relabang-s01e04-480p.mp4"]];
    [self.view addSubview:_moviePlayer];
    
    TLMoviePlayerController *aMoviePlayer = [[TLMoviePlayerController alloc] initWithFrame:CGRectMake(20, 240, 280, 200)];
    [aMoviePlayer setContentURL:[NSURL URLWithString:@"http://gslb.miaopai.com/stream/byVT434y7eChPxlw~qrHnA__.mp4?yx=&refer=weibo_app"]];
    [self.view addSubview:aMoviePlayer];
    
}

- (void) play {
//    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video4" ofType:@"mp4"]];
    NSURL*url = [NSURL URLWithString:@"http://203.166.162.84/video/relabang-s01e04-480p.mp4"];
    // http://gslb.miaopai.com/stream/byVT434y7eChPxlw~qrHnA__.mp4?yx=&refer=weibo_app
//    [self presentMoviePlayerViewControllerAnimated:viewController];
    
//    _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    _player.controlStyle = MPMovieControlStyleNone;
//    [_player prepareToPlay];
//    [_player.view setFrame:_myView.frame];
//    [self.view addSubview:_player.view];
//    
//    [_player.backgroundView setBackgroundColor:[UIColor blueColor]];
//    
//    
//    [_player play];
    
    
}

- (void) handlePlayerLoadStateDidChange:(NSNotification *) notification {
    
}

- (void) handlePlayerPlaybackStateDidChange:(NSNotification *) notification {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
