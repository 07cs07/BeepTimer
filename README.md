# BeepTimer #
=========

iOS App to beeps for every given interval asynchronously.

BeepTimer(.h,.m) is a subclass of NSObject, uses `dispatch_source_t` of type `DISPATCH_SOURCE_TYPE_TIMER` to run *asynchronously* in separate `Thread`.
***BeepTimer*** supports ***ARC*** and for non-ARC users just add the `-fobjc-arc` compiler flag to the BeepTimer files.

### How to use it

1. Add **AVFoundation** and **AudioToolbox** framework to your project.
2. Drag-and-drop BeepTimer(.h and .m) them into your Xcode project.
3. Tick the **Copy items into destination group's folder** option.
4. Use `#import "BeepTimer.h"` in  your source files.

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

 Copyright (C) 2013 Mobs and Geeks

 Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
 except in compliance with the License. You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software distributed under the
 License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 either express or implied. See the License for the specific language governing permissions and
 limitations under the License.
 
  @author Balachander.M <chicjai@gmail.com>
  @version 0.1
  