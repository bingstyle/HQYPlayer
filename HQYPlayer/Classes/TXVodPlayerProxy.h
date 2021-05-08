//
//  TXVodPlayerProxy.h
//  HQYPlayer_Example
//
//  Created by WeiXinbing on 2021/5/6.
//  Copyright © 2021 bingstyle. All rights reserved.
//

#if __has_include(<TXLiteAVSDK_Player/TXVodPlayer.h>)
#import <TXLiteAVSDK_Player/TXVodPlayer.h>
#define HasTXVodPlayer
#elif __has_include(<TXLiteAVSDK_Smart/TXVodPlayer.h>)
#import <TXLiteAVSDK_Smart/TXVodPlayer.h>
#define HasTXVodPlayer
#elif __has_include(<TXLiteAVSDK_Professional/TXVodPlayer.h>)
#import <TXLiteAVSDK_Professional/TXVodPlayer.h>
#define HasTXVodPlayer
#elif __has_include(<TXLiteAVSDK_Enterprise/TXVodPlayer.h>)
#import <TXLiteAVSDK_Enterprise/TXVodPlayer.h>
#define HasTXVodPlayer
#elif __has_include(<TXLiteAVSDK_UGC/TXVodPlayer.h>)
#import <TXLiteAVSDK_UGC/TXVodPlayer.h>
#define HasTXVodPlayer
#endif

#ifdef HasTXVodPlayer

@class TXVodPlayer;

#import <UIKit/UIKit.h>
#import "SCPlayerFactory.h"

@interface TXVodPlayerProxy: SCPlayerFactory

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString;
- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString isMute:(BOOL)mute;

@end

#endif


