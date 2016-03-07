//
//  TLMoviePlayerController.m
//  CaptureVideo
//
//  Created by 何江浩 on 16/3/4.
//  Copyright © 2016年 何江浩. All rights reserved.
//

#import "TLMoviePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TLMoviePlayerController ()

@property (nonatomic, strong) MPMoviePlayerController  *moviePlayer;
@property (nonatomic, strong) UISlider *durationSlider;

@end

@implementation TLMoviePlayerController

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [_moviePlayer.view setUserInteractionEnabled:YES];
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        [self setupMoviePlayer];
        [self setupDurationSlider];
    }
    return self;
}

- (void) setupMoviePlayer {
    _moviePlayer = [[MPMoviePlayerController alloc] init];
    _moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    _moviePlayer.view.contentMode = UIViewContentModeScaleAspectFit;
    _moviePlayer.controlStyle = MPMovieControlStyleNone;
    _moviePlayer.view.frame = self.bounds;
    _moviePlayer.shouldAutoplay = NO;
    [self addSubview:_moviePlayer.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadStateDidChangeNotification:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackStateDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}

- (void) setContentURL:(NSURL *)url {
    _moviePlayer.contentURL = url;
    [_moviePlayer prepareToPlay];
}

- (void) setupDurationSlider {
    
}

- (void) handleTapGesture:(UIGestureRecognizer *)gesture {
    switch (_moviePlayer.playbackState) {
        case MPMoviePlaybackStateStopped:{
            NSLog(@"stopped play");
            //判断是否有网
            [_moviePlayer play];
            break;
        }
        case MPMoviePlaybackStatePaused:{
            NSLog(@"paused play");
            [_moviePlayer play];
            break;
        }
        case MPMoviePlaybackStatePlaying:{
            NSLog(@"playing paused");
            [_moviePlayer pause];
            break;
        }
        default:
            break;
    }
}

- (void) handleLoadStateDidChangeNotification:(NSNotification *)notification {
    switch (_moviePlayer.loadState) {
        case MPMovieLoadStateUnknown:{
            NSLog(@"LoadState Unknown");
            break;
        }
        case MPMovieLoadStatePlayable:{
            NSLog(@"LoadState Playable");
            break;
        }
        case MPMovieLoadStatePlaythroughOK:{
            NSLog(@"LoadState PlaythroughOK");
            break;
        }
        case MPMovieLoadStateStalled:{
            NSLog(@"LoadState Stalled");
            break;
        }
        default:
            break;
    }
}

- (void) handlePlaybackStateDidChangeNotification:(NSNotification *)notification {
    
}

- (void) handlePlaybackDidFinishNotification:(NSNotification *)notification {
    
}

@end
