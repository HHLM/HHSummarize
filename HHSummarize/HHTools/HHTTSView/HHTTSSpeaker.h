//
//  HHTTSSpeaker.h
//  HHSummarize
//
//  Created by LXH on 2017/8/3.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <libkern/OSAtomic.h>
@interface HHTTSSpeaker : AVSpeechSynthesizer

@property (nonatomic, strong) AVSpeechUtterance *utterance;

@property (nonatomic, assign, readonly, getter=isPause) BOOL pause;

@property (nonatomic, assign, readonly, getter=isStop) BOOL stop;

@property (nonatomic, assign, readonly, getter=isStar) BOOL star;

+ (instancetype)shareSpeaker;

- (void)speakString:(NSString *)speakString;

- (void)ttstar;

- (void)ttpause;

- (void)ttstop;

@end
