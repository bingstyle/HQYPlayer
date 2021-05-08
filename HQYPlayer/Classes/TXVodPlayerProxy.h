//
//  TXVodPlayerProxy.h
//  HQYPlayer_Example
//
//  Created by WeiXinbing on 2021/5/6.
//  Copyright © 2021 bingstyle. All rights reserved.
//

#if __has_include(<TXLiteAVSDK_UGC/TXVodPlayer.h>)
#import <TXLiteAVSDK_UGC/TXVodPlayer.h>
#define HasTXVodPlayer
#elif __has_include(<TXLiteAVSDK_UGC/TXLiteAVSDK.h>)
#define HasTXVodPlayer
#endif
//
#ifdef HasTXVodPlayer

@class TXVodPlayer;

#import <UIKit/UIKit.h>
#import "SCPlayerFactory.h"

@interface TXVodPlayerProxy: SCPlayerFactory

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString;
- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString isMute:(BOOL)mute;

@end

#endif


