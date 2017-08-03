//
//  HHTTSModel.m
//  HHSummarize
//
//  Created by LXH on 2017/8/3.
//  Copyright © 2017年 HHL. All rights reserved.
//

#import "HHTTSModel.h"

@interface HHTTSModel ()

@property (nonatomic, strong) AVSpeechUtterance *utterance;
@end

@implementation HHTTSModel

+ (instancetype )shareTTS {
    static HHTTSModel *tts;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tts) {
            tts = [[HHTTSModel alloc] init];
        }
    });
    return tts;
}

/*--------------------- AVSpeechUtterance ------------------------*/
/**
 
 pitchMultiplier: 音高
 postUtteranceDelay: 读完一段后的停顿时间
 preUtteranceDelay: 读一段话之前的停顿
 rate: 读地速度, 系统提供了三个速度:
 AVSpeechUtteranceMinimumSpeechRate,
 AVSpeechUtteranceMaximumSpeechRate,
 AVSpeechUtteranceDefaultSpeechRate
 speechString: 要读的字符串
 voice: 使用的声音, 是AVSpeechSynthesisVoice对象
 volume: 音量
 */

/**
 
 说话: speakUtterance
 
 控制: continueSpeaking(继续说)，pauseSpeakingAtBoundary(暂停说话)，paused(暂停状态的属性)，speaking(说话的状态)，stopSpeakingAtBoundary(停止说话)
 */

/*----------------- AVSpeechSynthesizerDelegate -----------------*/
/**
 
 AVSpeechSynthesizerDelegate介绍
 
 合成器的委托, 对于一些事件, 提供了响应的接口.
 
 didCancelSpeechUtterance: 已经取消说话
 didContinueSpeechUtterance: 已经继续说话
 didFinishSpeechUtterance: 已经说完
 didPauseSpeechUtterance: 已经暂停
 didStartSpeechUtterance:已经开始
 willSpeakRangeOfSpeechString:将要说某段话
 */

/*--------------------- AVSpeechSynthesisVoice --------------------*/

/**
 * AVSpeechSynthesisVoice定义了一系列的声音, 主要是不同的语言和地区.
 
 
 voiceWithLanguage: 根据制定的语言, 获得一个声音.
 speechVoices: 获得当前设备支持的声音
 currentLanguageCode: 获得当前声音的语言字符串, 比如”ZH-cn”
 language: 获得当前的语言
 
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /**
         * 需要导入AVFoundtaion库
         *
         *  AVSpeechSynthersizer:   语音合成器，一个人在说话
         AVSpeechSynthesisVocie: 说话人的声音
         AVSpeechUtterance:      要说的一段话
         */
        
        // 该对象用于执行具体的“文本到语音”会话，对一个或多个AVSpeechUtterance实例起到队列的作用
        _synther = [[AVSpeechSynthesizer alloc] init];
        _synther.delegate = self;
        //记录目前系统音量
    }
    return self;
}

- (void)speaking:(NSString *)speakString {
    _utterance = [AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"%@",speakString]];
    _utterance.pitchMultiplier = 1.0;
    _utterance.volume = 0.6;
    _utterance.rate = 0.5;
    _utterance.postUtteranceDelay = 0.5;
    _utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]; //中文语音
    [_synther speakUtterance:_utterance];

    //_utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];

}
/*---------------------- AVSpeechBoundary ------------------------*/

/**
 * AVSpeechBoundary
 *
 * 这是一个枚举. 在暂停, 或者停止说话的时候, 停下的方式用这个枚举标示.
 包括两种:
 AVSpeechBoundaryImmediate: 立即停
 AVSpeechBoundaryWord : 说完一个整词再停
 */

- (void)ttpause {
   [_synther pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
}

- (void)ttstop {
   [_synther stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}

- (void)ttstar {
    if ([_synther isPaused]) {
        [_synther continueSpeaking];
    }else if ([_synther isSpeaking]) {
        return;
    }else {
        [_synther speakUtterance:_utterance];
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
