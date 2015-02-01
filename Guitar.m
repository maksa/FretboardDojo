//
//  Guitar.m
//  FretboardDojo
//
//  Created by Maksa on 2/1/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "Guitar.h"

@implementation Guitar


-(void)play:(NSString*)note atPosition:(Position*)position {

    NSUInteger harmonics[6][23] = {
        { 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4 },
        { 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4 },
        { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5 },
        { 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 },
        { 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
        { 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6 }
    };
    
    NSString* notestring = [ NSString stringWithFormat:@"%lu%@", (unsigned long)harmonics[position.string][position.fret], [ note lowercaseString ]];
                            
    NSString* notepath = [[NSBundle mainBundle]
                            pathForResource:notestring ofType:@"aiff"];
    
    NSURL* noteurl = [NSURL fileURLWithPath:notepath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)noteurl, &_notesound);
    AudioServicesPlaySystemSound(_notesound);
}
@end
