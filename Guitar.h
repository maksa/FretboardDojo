//
//  Guitar.h
//  FretboardDojo
//
//  Created by Maksa on 2/1/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Position.h"

@interface Guitar : NSObject {
    SystemSoundID _notesound;
}
-(void)play:(NSString*)note atPosition:(Position*)position;
@end
