//
//  Position.h
//  FretboardDojo
//
//  Created by Maksa on 1/31/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject
-(id)initWithString:(NSUInteger)string fret:(NSUInteger)fret;
@property NSUInteger string;
@property NSUInteger fret;
@end
