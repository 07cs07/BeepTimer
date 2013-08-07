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

#import "BeepTimerHomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "BeepTimer.h"

@interface BeepTimerHomeViewController ()<BeepTimerDelegate>
{
    BOOL running;
    BeepTimer *beepTimer;
}

@end

@implementation BeepTimerHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    beepTimer = [[BeepTimer alloc] init];
    beepTimer.delegate = self;
    beepTimer.lapInterval = 30;
    running = NO;
    self.timer.text = @"00:00:00";
    self.lapCounter.text = @"00";
    self.lapTime.text = [NSString stringWithFormat:@"%02d", (int)beepTimer.lapInterval];

    // This prevents the device from locking, while app is running
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOrPauseTimer:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!running) {
        [beepTimer start];
        [button setTitle:@"Pause" forState:UIControlStateNormal];
        [button setTitle:@"Pause" forState:UIControlStateSelected];
    }else {
        [beepTimer pause];
        [button setTitle:@"Start" forState:UIControlStateNormal];
        [button setTitle:@"Start" forState:UIControlStateSelected];
    }
    running = !running;
}

- (IBAction)stopTimer:(id)sender
{
    self.timer.text = @"00:00:00";
    self.lapCounter.text = @"00";
    running = NO;
    [beepTimer stop];
}

- (void)viewDidDisappear:(BOOL)animated
{
    beepTimer.delegate = nil;
    beepTimer = nil;
}

- (void)viewDidUnload
{
    [self setLapCounter:nil];
    [self setLapTime:nil];
    [self setLapCounter:nil];
    [super viewDidUnload];
}

#pragma mark - BeepTimer Delegates

- (void)updateHours:(int)hrs minutes:(int)mins andSeconds:(int)secs
{
    self.timer.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hrs, mins, secs];
}

- (void)updateLapCount:(int)lapCount
{
    self.lapCounter.text = [NSString stringWithFormat:@"%02d", (int)lapCount];
}

@end
