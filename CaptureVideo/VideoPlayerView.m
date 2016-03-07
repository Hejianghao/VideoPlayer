//
//  VideoPlayerView.m
//  CaptureVideo
//
//  Created by 何江浩 on 16/3/3.
//  Copyright © 2016年 何江浩. All rights reserved.
//

#import "VideoPlayerView.h"
#import "UIView+Frame.h"
#import <MediaPlayer/MediaPlayer.h>

typedef enum {
    SmallScreen = 0,
    FullScreen
}ScreenType;

@interface VideoPlayerView (){
    CGRect originFrame;
}

@property (nonatomic, strong) MPMoviePlayerController *player;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation VideoPlayerView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _player = [[MPMoviePlayerController alloc] init];
        _player.view.frame = self.bounds;
        _player.view.contentMode = UIViewContentModeScaleAspectFit;
        _player.repeatMode = MPMovieRepeatModeNone;
        _player.controlStyle = MPMovieControlStyleNone;
        _player.movieSourceType = MPMovieSourceTypeFile;
        _player.shouldAutoplay = NO;
        [_player.view setContentMode:UIViewContentModeScaleAspectFill];
        [_player.view setUserInteractionEnabled:YES];
        [self addSubview:_player.view];
        
        
        
        //http://wsqncdn.miaopai.com/stream/wAlnu4iufewbgwRIGf4s0g__.mp4?yx=&refer=weibo_app
//        _player.contentURL = [NSURL URLWithString:@"http://203.166.162.84/video/relabang-s01e04-480p.mp4"];
//        [_player prepareToPlay];
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 30, 280, 10)];
        _slider.value = 0.5f;
        [_slider setMinimumTrackTintColor:[UIColor blueColor]];
        [_slider setMaximumTrackTintColor:[UIColor blackColor]];
        [_slider setUserInteractionEnabled:NO];
//        [self addSubview:_slider];
        
        _coverView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_coverView setBackgroundColor:[UIColor clearColor]];
        _coverView.contentMode = UIViewContentModeScaleAspectFill;
        [_coverView setUserInteractionEnabled:YES];
//        [self addSubview:_coverView];
        
        [self addNotifications];
        [self addTapGesture];
    }
    return self;
}

- (void) setContentURL:(NSURL *)url {
    if (_player) {
        _player.contentURL = url;
    }
}

- (void) addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerPlaybackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //检测视频播放时长
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDurationAvailable) name:MPMovieDurationAvailableNotification object:nil];
    //检测是否可以播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlayerReadyForDisplayDidChange) name:MPMoviePlayerReadyForDisplayDidChangeNotification object:nil];
    //截取视频中的图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThumbnailImageRequestDidFinish:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThumbnailImageRequestDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //播放视频改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThumbnailImageRequestDidFinish:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
}

- (void) addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayerView:)];
    
    UIView *view = [[UIView alloc] initWithFrame:_player.view.bounds];
    [view setBackgroundColor:[UIColor clearColor]];
    [view addGestureRecognizer:tapGesture];
    [_player.view addSubview:view];

    UITapGestureRecognizer *tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundView:)];
    [self addGestureRecognizer:tapBackground];
}

- (void) handlePlayerLoadStateDidChange:(NSNotification *)notification {
    NSLog(@"loadState:%d",_player.loadState);
    
}

- (void) handlePlayerPlaybackStateDidChange:(NSNotification *) notification {//如何显示loading
    NSLog(@"playbackState:%d",_player.playbackState);
}

- (void) handlePlayerPlaybackDidFinish:(NSNotification *) notification {//has error message in userInfo
    
}

- (void) handlePlayerReadyForDisplayDidChange {
    
}

- (void) handleDurationAvailable {
    NSLog(@"...%f",_player.duration);
    NSNumber *number = [NSNumber numberWithDouble:0.0];
    [_player requestThumbnailImagesAtTimes:@[number] timeOption:MPMovieTimeOptionNearestKeyFrame];
}

- (void) handleThumbnailImageRequestDidFinish:(NSNotification *)notificaiton {
    UIImage *image = [notificaiton.userInfo objectForKey:MPMoviePlayerThumbnailImageKey];
    self.coverView.image = image;
    self.coverView.hidden = NO;
    [_coverView setFrame:CGRectMake(0, 0, 50, 50)];
}
/*
- (void) monitorPlaybackTime
{
    self.progressIndicator.value = self.mpMoviePlayerController.currentPlaybackTime / self.totalVideoTime;
    //constantly keep checking if at the end of video:
    if (self.totalVideoTime != 0 && videoPlayer.currentPlaybackTime >= totalVideoTime - 0.1)
    {
        //-------- rewind code:
        self.mpMoviePlayerController.currentPlaybackTime = 0;
        [self.mpMoviePlayerController pause];
    }
    else
    {
        [self performSelector:@selector(monitorPlaybackTime) withObject:nil afterDelay:kVideoPlaybackUpdateTime];
    }
}*/

- (void) tapPlayerView:(UIGestureRecognizer *)gesture {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.frame = CGRectMake(0, 0, 320, 480);
//    }];
    if (_player.playbackState == MPMoviePlaybackStateStopped || _player.playbackState == MPMoviePlaybackStatePaused) {
//        [_coverView setHidden:YES];
        _player.contentURL = [NSURL URLWithString:@"http://wsqncdn.miaopai.com/stream/wAlnu4iufewbgwRIGf4s0g__.mp4?yx=&refer=weibo_app"];
        [_player play];
        NSLog(@"__loadState:%d",_player.loadState);
        originFrame = _player.view.frame;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGRect newFrame = CGRectMake(-20, -100, 100, 100);
            [_player.view setFrame:newFrame];
            
        } completion:^(BOOL finished) {
            NSLog(@"animate completed");
        }];
//        [_player setFullscreen:YES animated:YES];
    } else if (_player.playbackState == MPMoviePlaybackStatePlaying){
//        [_coverView setHidden:NO];
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [_player.view setFrame:CGRectMake(0, 0, 280, 280)];
        } completion:^(BOOL finished) {
            
        }];
//        [_player pause];
    }
}

- (void) tapBackgroundView:(UIGestureRecognizer *)gesture {
    
}




@end
