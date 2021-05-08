//
//  SCMediaPlayback.h
//  SCGeneralPlayerSDK
//
//  Created by unblue on 2018/11/21.
//  Copyright © 2018年 MCloud. All rights reserved.


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCPlayerNaturalSizeChangedNotification @"sc_natural_size_changed"
#define SCPlayerVideoMetaChangedNotification   @"sc_video_meta_changed"
#define SCPlayerLoadStateChangedNotification   @"sc_load_state_changed"
#define SCPlayerPreparedToPlayNotification     @"sc_prepared_to_play"
#define SCPlayerPlayStateChangedNotification   @"sc_play_state_changed"
#define SCPlayerPlayFinishedNotification       @"sc_play_finished"
#define SCPlayerCacheProgressNotification      @"sc_cache_progress"
#define SCPlayerCacheProgressUserInfoKey       @"sc_cache_progress_key"
#define SCPlaybackDidFinishReasonUserInfoKey   @"sc_play_finish_reason_key"


typedef NS_ENUM(NSInteger, SCVideoPlayerType) {
    SCVideoPlayerTypeIJK, //IJKFFMoviePlayerController
    SCVideoPlayerTypeTXVod, //TXVod
};

typedef NS_ENUM(NSInteger, SCVideoType) {
    SCVideoTypeLocalVideo,
    SCVideoTypeOnline,
    SCVideoTypeLive
};

typedef NS_ENUM(NSInteger, SCVideoScaleMode) {
    SCVideoScaleModeNone,       // No scaling
    SCVideoScaleModeAspectFit,  // Uniform scale until one dimension fits
    SCVideoScaleModeAspectFill, // Uniform scale until the movie fills the visible bounds. One dimension may have clipped contents
    SCVideoScaleModeFill        // Non-uniform scale. Both render dimensions will exactly match the visible bounds
};

typedef NS_ENUM(NSInteger, SCVideoPlaybackState) {
    SCVideoPlaybackStateUnknown,
    SCVideoPlaybackStateStopped,
    SCVideoPlaybackStatePlaying,
    SCVideoPlaybackStatePaused,
    SCVideoPlaybackStateInterrupted,
    SCVideoPlaybackStateSeeking
};

typedef NS_OPTIONS(NSUInteger, SCVideoLoadState) {
    SCVideoLoadStateUnknown        = 0,
    SCVideoLoadStatePlayable       = 1 << 0,  //可用
    SCVideoLoadStateStalled        = 1 << 1,  //缓冲
};

typedef NS_ENUM(NSInteger, SCVideoFinishReason) {
    SCVideoFinishReasonUnknown,
    SCVideoFinishReasonPlaybackEnded,
    SCVideoFinishReasonPlaybackError,
    SCVideoFinishReasonUserExited
};

@protocol SCMediaPlayback <NSObject>
@optional
- (void)prepareToPlay;
- (void)play;
- (void)pause;
- (void)stop;
- (void)shutdown;
- (void)setScaleMode:(SCVideoScaleMode)scaleMode;
- (SCVideoPlayerType)playerType;
- (SCVideoLoadState)loadState;
- (SCVideoPlaybackState)playbackState;

@property (nonatomic, strong, readonly) UIView *playerView;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign) NSTimeInterval currentPlayTime; //unit: second
@property (nonatomic, assign, readonly) NSTimeInterval duration;

@property (nonatomic, copy, readonly) NSString *vCodecString;
@property(nonatomic, readonly) CGSize naturalSize;
@property(nonatomic, readonly) NSTimeInterval cacheProgress;
@end
