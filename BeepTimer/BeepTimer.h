//
//  BeepTimer.h
//  BeepTimer
//
//  Created by MaG~2 on 23/04/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@protocol BeepTimerDelegate <NSObject>

@optional
- (void)updatedHours:(int)hrs minutes:(int)mins andSeconds:(int)secs;
- (void)updatedLapCount:(int)lapCount;
@end

@interface BeepTimer : NSObject
{
    AVAudioPlayer *player;
    NSTimer *myTimer;
    BOOL running;
    UIBackgroundTaskIdentifier bgTask;
}

@property (nonatomic) int hours;
@property (nonatomic) int minutes;
@property (nonatomic) int seconds;
@property (nonatomic) int lapCount;
@property (nonatomic) int lapInterval;


@property (strong) id <BeepTimerDelegate> delegate;

- (void)start;
- (void)stop;
- (void)reset;
@end
