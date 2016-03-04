//
//  VideoPlayerView.h
//  CaptureVideo
//
//  Created by 何江浩 on 16/3/3.
//  Copyright © 2016年 何江浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerView : UIView

@property (nonatomic, strong) UIImageView *coverView;

- (void) setContentURL:(NSURL *)url;

@end
