//
//  BeepTimerHomeViewController.h
//  BeepTimer
//
//  Created by MaG~2 on 10/04/13.
//  Copyright (c) 2013 Mobs and Geeks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeepTimerHomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) IBOutlet UILabel *lapTime;
@property (strong, nonatomic) IBOutlet UILabel *lapCounter;

- (IBAction)startTimer:(id)sender;

- (IBAction)stopTimer:(id)sender;

@end
