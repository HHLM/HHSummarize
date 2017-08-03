//
//  HHTTSSpeaker.m
//  HHSummarize
//
//  Created by LXH on 2017/8/3.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHTTSSpeaker.h"

@interface HHTTSSpeaker ()<AVSpeechSynthesizerDelegate>

@end

@implementation HHTTSSpeaker

+(instancetype)shareSpeaker {
    static HHTTSSpeaker *speaker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!speaker) {
            speaker = [[HHTTSSpeaker alloc] init];
        }
    });
    return speaker;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)speakString:(NSString *)speakString {
    
    AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"%@",speakString]];
    utt.pitchMultiplier = 1.0;
    utt.volume = 0.6;
    utt.rate = 0.5;
    utt.postUtteranceDelay = 0.5;
    utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]; //中文语音
    [self speakUtterance:utt];
    _utterance = utt;
    
}

- (void)ttpause {
    [self pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
}

- (void)ttstop {
    [self stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}

- (void)ttstar {
    if ([self isPaused]) {
        [self continueSpeaking];
    }else if ([self isSpeaking]) {
        return;
    }else {
        [self speakUtterance:_utterance];
    }
}


/*--------------------------- 我是分割线 ---------------------------*/


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    _pause = YES;
    _stop = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    _pause = NO;
    _stop = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    _pause = NO;
    _stop = NO;
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
}
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    _pause = NO;
    _stop = YES;
}

@end
