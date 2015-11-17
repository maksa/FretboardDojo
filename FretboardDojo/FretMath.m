//
//  FretMath.m
//  FretboardDojo
//
//  Created by Maksa on 11/16/15.
//  Copyright © 2015 MM. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "FretMath.h"

@implementation FretMath
+(CGFloat*)fretConstants {
    static CGFloat fretConstants[] = {
        0,
        1.43,
        2.78,
        4.06,
        5.26,
        6.40,
        7.47,
        8.48,
        9.44,
        10.34,
        11.19,
        11.99,
        12.75,
        13.47,
        14.14,
        14.78,
        15.38,
        15.95,
        16.48,
        16.99,
        17.47,
        17.92,
        18.34,
    };
    NSAssert( sizeof(fretConstants)/sizeof(CGFloat) == NUMBER_OF_FRETS, @"must have enough scale factors");
    
    return fretConstants;
}
@end
