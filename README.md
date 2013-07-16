# BeepTimer #
=========

This is a project for iOS that beeps for every 30 secs.

BeepTimer(.h,.m) is a subclass of NSObject ,designed to be very efficient and uses delegate pattern

### ARC Support ###
***BeepTimer*** supports ***ARC*** and for non-ARC users just add the `-fobjc-arc` compiler flag to the BeepTimer files.

### Installation ###

### Frameworks :
- **AVFoundation**
- **AudioToolbox**

### How to use it

1. Drag-and-drop BeepTimer(.h and .m) them into your Xcode project.
2. Tick the **Copy items into destination group's folder** option.
3. Use `#import "BeepTimer.h"` in  your source files.

### Sample Code
	
```objective-c

    BeepTimer *beepTimer;

    beepTimer = [[BeepTimer alloc] init];
    beepTimer.delegate = self;

    [beepTimer start]; // this will Start the BeepTimer

    [beepTimer pause]; // this will pause the BeepTimer

    [beepTimer reset]; // this will reset/stop the Beeptimer
```

*BeepTimer has two delegate methods*

- **- (void)updateHours:(int)hrs minutes:(int)mins andSeconds:(int)secs;** This lets you to update the time in UI for every secs.

- **- (void)updateLapCount:(int)lapCount;** This lets you to update the current lap of the timer.

 