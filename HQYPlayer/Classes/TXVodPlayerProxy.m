//
//  TXVodPlayerProxy.m
//  HQYPlayer_Example
//
//  Created by WeiXinbing on 2021/5/6.
//  Copyright © 2021 bingstyle. All rights reserved.
//

#import "TXVodPlayerProxy.h"

#ifdef HasTXVodPlayer

@interface TXVodPlayerProxy ()<TXVodPlayListener>
{
    TXVodPlayer *_vodPlayer;
    NSString *url;
    UIView *playerView;
    SCVideoLoadState _loadState;
    SCVideoPlaybackState _playbackState;
}
@end

@implementation TXVodPlayerProxy

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString {
    return [self initWithFrame:frame URLString:urlString isMute:NO];
}

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString isMute:(BOOL)mute {
    self = [super init];
    if (self) {
        url = urlString;
        TXVodPlayConfig *defaultConfig = [[TXVodPlayConfig alloc] init];
        NSString *tmpDir = NSTemporaryDirectory();
        defaultConfig.cacheFolderPath = tmpDir;
        defaultConfig.maxBufferSize = 0.5;
        defaultConfig.playerType = 0;
        defaultConfig.maxCacheItems = 5;
        _vodPlayer = [[TXVodPlayer alloc] init];
        _vodPlayer.config = defaultConfig;
        _vodPlayer.enableHWAcceleration = YES;
        _vodPlayer.isAutoPlay = YES;
        _vodPlayer.loop = YES;
        _vodPlayer.vodDelegate = self;
        
        playerView = [[UIView alloc] initWithFrame:frame];
        [_vodPlayer setupVideoWidget:playerView insertIndex:0];
        
        _loadState = SCVideoLoadStateUnknown;
        _playbackState = SCVideoPlaybackStateUnknown;
    }
    return self;
}

#pragma mark - TXVodPlayListener
- (void)onPlayEvent:(TXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary *)param {
    switch (EvtID) {
        case PLAY_EVT_PLAY_BEGIN:
        {
            [self playStateChanged:nil];
        } break;
        case PLAY_EVT_PLAY_END:
        {
            [self playFinished:param];
        } break;
        case PLAY_EVT_PLAY_LOADING:
        {
            _loadState = SCVideoLoadStateStalled;
            [self loadStateChanged:nil];
        } break;
        case PLAY_EVT_VOD_LOADING_END:
        {
            _loadState = SCVideoLoadStatePlayable;
            [self loadStateChanged:nil];
        } break;
        case PLAY_EVT_VOD_PLAY_PREPARED:
        {
            [self preparedToPlayChanged:nil];
        } break;
        default:
            break;
    }
}

- (void)onNetStatus:(TXVodPlayer *)player withParam:(NSDictionary *)param {
    
}

#pragma mark - SCPlayer Notifications

- (void)loadStateChanged:(NSNotification *)notif
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerLoadStateChangedNotification
                                                        object:self];
}

- (void)playFinished:(NSDictionary *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SCPlayerPlayFinishedNotification
                                                        object:self
                                                      userInfo:info];
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
    [_vodPlayer startPlay:url];
}

-(UIView *)playerView
{
    return playerView;
}

- (BOOL)isPlaying
{
    return [_vodPlayer isPlaying];
}

- (void)play
{
    if (_playbackState == SCVideoPlaybackStatePaused) {
        [_vodPlayer resume];
    }else{
        [_vodPlayer startPlay:url];
    }
    _playbackState = SCVideoPlaybackStatePlaying;
}

- (void)pause
{
    [_vodPlayer pause];
    _playbackState = SCVideoPlaybackStatePaused;
}

- (void)stop
{
    [_vodPlayer stopPlay];
    _playbackState = SCVideoPlaybackStateStopped;
}

-(void)shutdown
{
    [self stop];
}

- (void)setScaleMode:(SCVideoScaleMode)scaleMode
{
    TX_Enum_Type_RenderMode mode = RENDER_MODE_FILL_SCREEN;
    switch (scaleMode) {
        case SCVideoScaleModeFill:
            mode = RENDER_MODE_FILL_SCREEN;
            break;
        case SCVideoScaleModeAspectFit:
            mode = RENDER_MODE_FILL_EDGE;
            break;
        default:
            break;
    }
    [_vodPlayer setRenderMode: mode];
}

- (NSTimeInterval)currentPlayTime
{
    return _vodPlayer.currentPlaybackTime;
}

- (void)setCurrentPlayTime:(NSTimeInterval)currentPlayTime
{
    [_vodPlayer seek:currentPlayTime];
}

- (NSTimeInterval)duration
{
    return _vodPlayer.duration;
}

- (NSString *)vCodecString
{
    return @"";
}

- (SCVideoPlayerType)playerType
{
    return SCVideoPlayerTypeIJK;
}

- (SCVideoLoadState)loadState
{
    return _loadState;
}

- (SCVideoPlaybackState)playbackState
{
    return _playbackState;
}

- (CGSize)naturalSize
{
    return playerView.frame.size;
}

- (NSTimeInterval)cacheProgress
{
    return _vodPlayer.playableDuration;
}

@end

#endif
