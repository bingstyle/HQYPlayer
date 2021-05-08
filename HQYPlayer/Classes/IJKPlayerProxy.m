//
//  IJKPlayerProxy.m
//  SCGeneralPlayerSDK
//
//  Created by unblue on 2018/11/21.
//  Copyright © 2018年 MCloud. All rights reserved.

#import "IJKPlayerProxy.h"

#if __has_include(<IJKMediaFramework/IJKMediaFramework.h>)
@import IJKMediaFramework;

@interface IJKPlayerProxy ()
{
    IJKFFMoviePlayerController *_ijkPlayer;
    SCVideoLoadState _loadState;
    SCVideoPlaybackState _playbackState;
}
@end

@implementation IJKPlayerProxy

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString {
    return [self initWithFrame:frame URLString:urlString isMute:NO];
}

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString isMute:(BOOL)mute {
    self = [super init];
    if (self) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        if (mute) { [options setPlayerOptionValue:@"1" forKey:@"an"];
        } else { [options setPlayerOptionValue:@"0" forKey:@"an"]; }
//        [options setFormatOptionIntValue:1024 * 16 forKey:@"probesize"];
//        [options setPlayerOptionIntValue:0 forKey:@"max_cached_duration"];
        //[options setPlayerOptionIntValue:0 forKey:@"infbuf"];
        [options setPlayerOptionIntValue:0 forKey:@"videotoolbox"];
        _ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:urlString withOptions:options];
        [_ijkPlayer setFormatOptionValue:@"" forKey:@"headers"];
        _ijkPlayer.view.frame = frame;
        
        //_ijkPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //_ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
        //[_ijkPlayer prepareToPlay];
        
        _loadState = SCVideoLoadStateUnknown;
        _playbackState = SCVideoPlaybackStateUnknown;
        
        [self installNotifications];
    }
    return self;
}


- (void)installNotifications
{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadStateChanged:)
                                                     name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                   object:_ijkPlayer];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playFinished:)
                                                     name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                   object:_ijkPlayer];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(preparedToPlayChanged:)
                                                     name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                   object:_ijkPlayer];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playStateChanged:)
                                                     name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:_ijkPlayer];
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(naturalSizeAvailable:)
                                                     name:IJKMPMovieNaturalSizeAvailableNotification
                                                   object:_ijkPlayer];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - SCPlayer Notifications

- (void)loadStateChanged:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerLoadStateChangedNotification
                                                        object:self];
}

- (void)playFinished:(NSNotification *)notif
{
    SCVideoFinishReason reason = SCVideoFinishReasonUnknown;
    int originReason =[[[notif userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (originReason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            reason = SCVideoFinishReasonPlaybackEnded;
            break;
        case IJKMPMovieFinishReasonPlaybackError:
            reason = SCVideoFinishReasonPlaybackError;
            break;
        case IJKMPMovieFinishReasonUserExited:
            reason = SCVideoFinishReasonUserExited;
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerPlayFinishedNotification
                                                        object:self
                                                      userInfo:@{SCPlaybackDidFinishReasonUserInfoKey: @(reason)}];
}

- (void)playStateChanged:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerPlayStateChangedNotification
                                                        object:self];
}

- (void)preparedToPlayChanged:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerPreparedToPlayNotification
                                                        object:self];
}

- (void)naturalSizeAvailable:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerNaturalSizeChangedNotification
                                                        object:self];
}

#pragma mark - SCMediaPlayback Delegate
-(void)prepareToPlay
{
    [_ijkPlayer prepareToPlay];
}

-(UIView *)playerView
{
    return _ijkPlayer.view;
}

- (BOOL)isPlaying
{
    return [_ijkPlayer isPlaying];
}

- (void)play
{
    [_ijkPlayer play];
}

- (void)pause
{
    [_ijkPlayer pause];
}

- (void)stop
{
    [_ijkPlayer stop];
}

-(void)shutdown
{
    [_ijkPlayer shutdown];
}


- (void)setScaleMode:(SCVideoScaleMode)scaleMode
{
    IJKMPMovieScalingMode mode = IJKMPMovieScalingModeNone;
    switch (scaleMode) {
        case SCVideoScaleModeFill:
            mode = IJKMPMovieScalingModeFill;
            break;
        case SCVideoScaleModeAspectFit:
            mode = IJKMPMovieScalingModeAspectFit;
            break;
        case SCVideoScaleModeAspectFill:
            mode = IJKMPMovieScalingModeAspectFill;
            break;
        default:
            break;
    }
    [_ijkPlayer setScalingMode: mode];
}

- (NSTimeInterval)currentPlayTime
{
    return _ijkPlayer.currentPlaybackTime;
}

- (void)setCurrentPlayTime:(NSTimeInterval)currentPlayTime
{
    _ijkPlayer.currentPlaybackTime = currentPlayTime;
}

- (NSTimeInterval)duration
{
    return _ijkPlayer.duration;
}

- (NSString *)vCodecString
{
    return _ijkPlayer.monitor.vcodec;
}

- (SCVideoPlayerType)playerType
{
    return SCVideoPlayerTypeIJK;
}

- (SCVideoLoadState)loadState
{
    IJKMPMovieLoadState state = _ijkPlayer.loadState;
    switch (state) {
        case IJKMPMovieLoadStatePlayable | IJKMPMovieLoadStatePlaythroughOK:
            _loadState = SCVideoLoadStatePlayable;
            break;
        case IJKMPMovieLoadStateStalled:
            _loadState = SCVideoLoadStateStalled;
            break;
        default:
            break;
    }
    return _loadState;
}

- (SCVideoPlaybackState)playbackState
{
    IJKMPMoviePlaybackState state = _ijkPlayer.playbackState;
    switch (state) {
        case IJKMPMoviePlaybackStatePlaying:
            _playbackState = SCVideoPlaybackStatePlaying;
            break;
        case IJKMPMoviePlaybackStatePaused:
            _playbackState = SCVideoPlaybackStatePaused;
            break;
        case IJKMPMoviePlaybackStateStopped:
            _playbackState = SCVideoPlaybackStateStopped;
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            _playbackState = SCVideoPlaybackStateInterrupted;
            break;
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward:
            _playbackState = SCVideoPlaybackStateSeeking;
            break;
        default:
            break;
    }
    return _playbackState;
}

- (CGSize)naturalSize
{
    return _ijkPlayer.naturalSize;
}

- (NSTimeInterval)cacheProgress
{
    return _ijkPlayer.playableDuration;
}

@end

#endif
