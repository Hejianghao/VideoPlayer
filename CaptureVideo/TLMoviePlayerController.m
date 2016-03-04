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
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UISlider *durationSlider;

@end

@implementation TLMoviePlayerController

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupMoviePlayer];
        [self setupCoverImage];
        [self setupDurationSlider];
    }
    return self;
}

- (void) setupMoviePlayer {
    _moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    _moviePlayer.view.contentMode = UIViewContentModeScaleAspectFit;
    _moviePlayer.view.frame = self.bounds;
    _moviePlayer.shouldAutoplay = NO;
    [self addSubview:_moviePlayer.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadStateDidChangeNotification:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackStateDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}

- (void) setupCoverImage {
    _coverImage = [[UIImageView alloc] initWithFrame:self.bounds];
    _coverImage.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapCoverImage:)];
    [_coverImage addGestureRecognizer:tapGesture];
    [self addSubview:_coverImage];
}

- (void) setContentURL:(NSURL *)url {
    _moviePlayer.contentURL = url;
    [_moviePlayer prepareToPlay];
}

- (void) setupDurationSlider {
    
//    [self addSubview:_durationSlider];
}

- (void) handleTapCoverImage:(UIGestureRecognizer *)gesture {
    switch (_moviePlayer.playbackState) {
        case MPMoviePlaybackStateStopped:{
            [_moviePlayer play];
            break;
        }
        case MPMoviePlaybackStatePaused:{
            [_moviePlayer play];
            break;
        }
        case MPMoviePlaybackStatePlaying:{
            [_moviePlayer pause];
            break;
        }
        default:
            break;
    }
}

- (void) handleLoadStateDidChangeNotification:(NSNotification *)notification {
    
}

- (void) handlePlaybackStateDidChangeNotification:(NSNotification *)notification {
    
}

- (void) handlePlaybackDidFinishNotification:(NSNotification *)notification {
    
}

@end
