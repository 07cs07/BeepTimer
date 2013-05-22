//
//  BeepTimerHomeViewController.m
//  BeepTimer
//
//  Created by MaG~2 on 10/04/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

#import "BeepTimerHomeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "BeepTimer.h"

@interface BeepTimerHomeViewController ()<BeepTimerDelegate>
{
    AVAudioPlayer *player;
    NSTimer *myTimer;
    BOOL running;
    UIBackgroundTaskIdentifier bgTask;
    BeepTimer *beepTimer;
}

@end

@implementation BeepTimerHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    beepTimer = [[BeepTimer alloc] init];
    beepTimer.delegate = self;
    
    self.timer.text = @"00:00:00";
    self.lapCounter.text = [NSString stringWithFormat:@"Lap Counter: %02d", (int)beepTimer.lapCount];
    self.lapTime.text = [NSString stringWithFormat:@"Lap Time: %02d", (int)beepTimer.lapInterval];

    // This prevents the device from locking,while app is running
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTimer:(id)sender
{
    [beepTimer start];
}

- (IBAction)stopTimer:(id)sender
{
    [beepTimer stop];
}

- (IBAction)resetTimer:(id)sender
{
    self.timer.text = @"00:00:00";
    [beepTimer reset];
}

- (void)updatedHours:(int)hrs minutes:(int)mins andSeconds:(int)secs
{
    self.timer.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hrs, mins, secs];
}

- (void)updatedLapCount:(int)lapCount
{
    self.lapCounter.text = [NSString stringWithFormat:@"Lap Counter: %02d", (int)lapCount];
}

- (void)viewDidUnload
{
    [self setLapCounter:nil];
    [self setLapTime:nil];
    [self setLapCounter:nil];
    [super viewDidUnload];
}
@end
