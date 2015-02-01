//
//  Position.m
//  FretboardDojo
//
//  Created by Maksa on 1/31/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "Position.h"

@implementation Position
-(id)initWithString:(NSUInteger)string fret:(NSUInteger)fret {
    self = [ super init ];
    if( self ) {
        self.string = string;
        self.fret = fret;
    }
    return self;
}
@end
