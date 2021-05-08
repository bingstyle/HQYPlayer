//
//  SCPlayerFactory.m
//  AppFactory
//
//  Created by unblue on 2019/1/17.
//  Copyright © 2019 appfac. All rights reserved.
//

#import "SCPlayerFactory.h"
#import "IJKPlayerProxy.h"
#import "TXVodPlayerProxy.h"

@implementation SCPlayerFactory

+ (instancetype)playerWithType:(SCVideoPlayerType)playerType frame:(CGRect)frame URLString:(NSString *)urlString videoType:(SCVideoType)videoType
{
    SCPlayerFactory *player = [[self alloc] initPlayerWithType:playerType frame:frame URLString:urlString videoType:videoType isMute:false];
    return player;
}
+ (instancetype)playerWithType:(SCVideoPlayerType)playerType frame:(CGRect)frame URLString:(NSString *)urlString videoType:(SCVideoType)videoType isMute:(BOOL)mute {
    
    SCPlayerFactory *player = [[self alloc] initPlayerWithType:playerType frame:frame URLString:urlString videoType:videoType isMute:mute];
    return player;
}

#pragma mark - Private
- (instancetype)initPlayerWithType:(SCVideoPlayerType)playerType frame:(CGRect)frame URLString:(NSString *)urlString videoType:(SCVideoType)videoType isMute:(BOOL)mute
{
    NSLog(@"233---");
#if __has_include(<IJKMediaFramework/IJKMediaFramework.h>)
    if (playerType == SCVideoPlayerTypeIJK) {
        self = [[IJKPlayerProxy alloc] initWithFrame:frame URLString:urlString isMute:mute];
    }
#endif
#ifdef HasTXVodPlayer
    if (playerType == SCVideoPlayerTypeTXVod) {
        self = [[TXVodPlayerProxy alloc] initWithFrame:frame URLString:urlString isMute:mute];
    }
#endif
    return self;
}



@end
