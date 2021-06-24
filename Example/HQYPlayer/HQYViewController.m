//
//  HQYViewController.m
//  HQYPlayer
//
//  Created by bingstyle on 04/30/2021.
//  Copyright (c) 2021 bingstyle. All rights reserved.
//

#import "HQYViewController.h"

#if __has_include("IJKMediaFramework/IJKMediaFramework.h")

#endif
#import <SCPlayerFactory.h>


@interface HQYViewController ()

@end

@implementation HQYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SCPlayerFactory *player = [SCPlayerFactory playerWithType:SCVideoPlayerTypeTXVod frame:self.view.bounds URLString:@"www.baidu.com" videoType:SCVideoTypeOnline];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
