/*
 * Copyright (C) 2013 Mobs and Geeks
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the
 * License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author Balachander.M <chicjai@gmail.com>
 * @version 0.1
 */

#import "BeepTimer.h"

static NSInteger counter = 0;
static NSInteger lapCounter = 0;
static NSInteger lapTime = 30;

@implementation BeepTimer
@synthesize hours;
@synthesize minutes;
@synthesize seconds;
@synthesize lapInterval;

- (id)init
{
    self = [super init];
    if (self)
    {
        running = NO;
        lapInterval = lapTime;
        [self prepareBeepSound];
    }
    return self;
}

- (void)prepareBeepSound
{
    NSError *error;
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    beepSoundPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    [beepSoundPlayer setVolume:10.0];
    [beepSoundPlayer prepareToPlay];
    
    if (beepSoundPlayer == nil)
        NSLog(@"%@",[error description]);
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

- (void)pause
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
    
    if ([self.delegate respondsToSelector:@selector(updateHours:minutes:andSeconds:)])
        [self.delegate updateHours:hours minutes:minutes andSeconds:seconds];
    
    if (counter % lapInterval == 0 && counter) // lapInterval default 30 Seconds
    {
        [self playBeepSound];
        lapCounter++;
        if ([self.delegate respondsToSelector:@selector(updateLapCount:)])
            [self.delegate updateLapCount:(int)lapCounter];
    }
}

- (void)playBeepSound
{
    if (beepSoundPlayer) {
        [beepSoundPlayer play];
    }else{
        [self prepareBeepSound];
        [beepSoundPlayer play];
    }
}

- (void)stop
{
    [myTimer invalidate];
    myTimer = nil;
    counter = -1;
    lapCounter = 0;
    [self updateTimer:myTimer];
    running = NO;
}

@end
