//
//  IJKPlayerProxy.h
//  SCGeneralPlayerSDK
//
//  Created by unblue on 2018/11/21.
//  Copyright © 2018年 MCloud. All rights reserved.

#if __has_include(<IJKMediaFramework/IJKMediaFramework.h>)

#import <UIKit/UIKit.h>
#import "SCPlayerFactory.h"

@interface IJKPlayerProxy: SCPlayerFactory

- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString;
- (instancetype)initWithFrame:(CGRect)frame URLString:(NSString *)urlString isMute:(BOOL)mute;

@end

#endif
