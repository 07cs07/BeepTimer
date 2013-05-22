//
//  BeepTimer.m
//  BeepTimer
//
//  Created by MaG~2 on 23/04/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//


#import "BeepTimer.h"

static NSInteger counter = 0;
static NSInteger lapCounter = 0;
static NSInteger lapTime = 30;

@implementation BeepTimer
@synthesize hours;
@synthesize minutes;
@synthesize seconds;

- (id)init
{
    self = [super init];
    if (self)
    {
        running = NO;
    }
    return self;
}

- (void)start
{
    running =! running;
    if (running) {
        [myTimer invalidate];
        myTimer = nil;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1.0
                                                   target:self
                                                 selector:@selector(updateTimer:)
                                                 userInfo:nil
                                                  repeats:YES];
    }
}

- (void)stop
{
    [myTimer invalidate];
    myTimer = nil;
    running = NO;
    
}

-(void)updateTimer:(NSTimer *)timer
{
    counter++;
    seconds = counter % 60;
    minutes = (counter / 60) % 60;
    hours = counter / 3600;
    
    if ([self.delegate respondsToSelector:@selector(updatedHours:minutes:andSeconds:)])
        [self.delegate updatedHours:hours minutes:minutes andSeconds:seconds];
    
    if (counter % lapTime == 0 && counter) // For Every 30 Seconds
    {
        NSError *error;
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"alert_beep" ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
        [player setVolume:2.0];
        [player prepareToPlay];
        
        if (player == nil)
            NSLog(@"%@",[error description]);
        else
            [player play]; // TODO: Have to work on it
        lapCounter++;
        if ([self.delegate respondsToSelector:@selector(updatedLapCount:)])
            [self.delegate updatedLapCount:(int)lapCounter];
    }
}

- (void)reset
{
    [myTimer invalidate];
    myTimer = nil;
    counter = -1;
    [self updateTimer:myTimer];
    lapCounter = 0;
    running = NO;
}

@end
