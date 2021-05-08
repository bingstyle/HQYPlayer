//
//  SCPlayerFactory.h
//  AppFactory
//
//  Created by unblue on 2019/1/17.
//  Copyright © 2019 appfac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCMediaPlayback.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCPlayerFactory : NSObject <SCMediaPlayback>
+ (instancetype)playerWithType:(SCVideoPlayerType)playerType frame:(CGRect)frame URLString:(NSString *)urlString videoType:(SCVideoType)videoType;

//静音播放器
+ (instancetype)playerWithType:(SCVideoPlayerType)playerType frame:(CGRect)frame URLString:(NSString *)urlString videoType:(SCVideoType)videoType isMute:(BOOL)mute;

@end

NS_ASSUME_NONNULL_END
