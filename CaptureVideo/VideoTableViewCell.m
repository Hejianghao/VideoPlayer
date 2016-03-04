//
//  VideoTableViewCell.m
//  CaptureVideo
//
//  Created by 何江浩 on 16/3/2.
//  Copyright © 2016年 何江浩. All rights reserved.
//

#import "VideoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation VideoTableViewCell

//- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    if (self) {
////        [self setBackgroundColor:[UIColor redColor]];
////        MPMoviePlayerController *playerController = []
//    }
//    return self;
//}

- (id) initWithIdentifier:(NSString *)identifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
        [videoView setBackgroundColor:[UIColor redColor]];
        [self addSubview:videoView];
        
        //增加视频播放器
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"video4" ofType:@"mp4"];
        if (filePath) {
            NSURL *url = [NSURL fileURLWithPath:filePath];
            MPMoviePlayerController *playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
            [playerController prepareToPlay];
            [playerController.view setFrame:videoView.bounds];
            [videoView addSubview:playerController.view];
            [playerController play];
        } else {
            NSLog(@"播放文件不存在");
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
