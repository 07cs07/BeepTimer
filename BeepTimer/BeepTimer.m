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
    [beepSoundPlayer setVolume:1.0];
    [beepSoundPlayer prepareToPlay];
    
    if (beepSoundPlayer == nil)
        NSLog(@"%@",[error description]);
}

- (void)start
{
    running =! running;
    if (running) {
        dispatchTimer = CreateDispatchTimer(1ull * NSEC_PER_SEC, (1ull * NSEC_PER_SEC)/10 , dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self updateTimer];
        });
    }
    else {
        dispatch_resume(dispatchTimer);
    }
}

- (void)pause
{
    dispatch_suspend(dispatchTimer);
}

- (void)stop
{
    running = NO;
    RemoveDispatchTimer(dispatchTimer);
    dispatchTimer = nil;
    counter = -1;
    lapCounter = 0;
    [self updateTimer];
}

dispatch_source_t CreateDispatchTimer(uint64_t interval, uint64_t leeway, dispatch_queue_t queue, dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer)
    {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}

void RemoveDispatchTimer(dispatch_source_t mySource)
{
    dispatch_source_cancel(mySource);
}

-(void)updateTimer
{
    counter++;
    seconds = counter % 60;
    minutes = (counter / 60) % 60;
    hours = counter / 3600;
    
    if ([self.delegate respondsToSelector:@selector(updateHours:minutes:andSeconds:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate updateHours:hours minutes:minutes andSeconds:seconds];
        });
    }
    
    if (counter % lapInterval == 0 && counter) // lapInterval default 30 Seconds
    {
        [self playBeepSound];
        lapCounter++;
        if ([self.delegate respondsToSelector:@selector(updateLapCount:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate updateLapCount:(int)lapCounter];
            });
        }
    }
}

- (void)playBeepSound
{
    if (beepSoundPlayer) {
        [beepSoundPlayer play];
    }
    else {
        [self prepareBeepSound];
        [beepSoundPlayer play];
    }
}

@end
