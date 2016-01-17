//
//  FretboardView.m
//  FretboardDojo
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "FretboardView.h"
#import "Position.h"
#import "FretMath.h"

#define MARGIN 20
#define STRING_GAP 16
#define DOT_RADIUS 8
#define NECK_LENGTH 18.34
#define TOP_MARGIN (self.frame.size.height - STRING_GAP * 7)/2
#define F2W_SCALE (self.frame.size.width - MARGIN * 2) / NECK_LENGTH
#define MARKER_SIZE 16

@implementation FretboardView

-(NSArray*)allNotePositions:(NSString*)findnote {
    __block NSMutableArray* notePositions = [[ NSMutableArray alloc ] init];
    [self.notes enumerateObjectsUsingBlock:^(NSArray* string, NSUInteger stringidx, BOOL *stop) {
        [string enumerateObjectsUsingBlock:^(NSString* note, NSUInteger fretidx, BOOL *stop) {
            if( [findnote isEqualToString:note] ) {
                Position* position = [[ Position alloc ] initWithString:stringidx fret:fretidx];
                [notePositions addObject:position];
            }
        }];
    }];
    
    return [notePositions copy];
}

-(void)clearMarkers {
    [self.markers enumerateObjectsUsingBlock:^(CALayer* marker, NSUInteger idx, BOOL *stop) {
        [ marker removeFromSuperlayer ];
    }];
}

-(NSArray*)notes {
    static NSArray* notes;
    
    if( notes == nil ) {
        notes = @[
                  @[ @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C" ,@"C#", @"D"],
                  
                  @[ @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G"],
                  
                  @[@"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C", @"C#",@"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C"],
                  
                  @[@"G", @"G#", @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#",@"G", @"G#", @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F"],
                  
                  @[@"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#",@"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A"],
                  
                  @[ @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B", @"C",@"C#", @"D" ]
                  ];
    }


    NSLog(@"notes: %lu", (unsigned long)notes.count );
    NSArray* a = notes[0];
    NSLog(@"notes: %lu", (unsigned long)a.count );
    return notes;
}

-(NSString*)noteOnString:(NSInteger)n_string fret:(NSInteger)fret
{
    return self.notes[n_string][fret];
}

-(void)showNoteNameMarker:(NSUInteger)n_string fret:(NSUInteger)fret {
    CGFloat* fretConstants = [ FretMath fretConstants ];
    CGFloat Xfret0 = fretConstants[fret-1] * F2W_SCALE + MARGIN;
    CGFloat Xfret1 = fretConstants[fret] * F2W_SCALE + MARGIN;
    CGFloat xPos = Xfret0 + (Xfret1 - Xfret0)/2 - MARKER_SIZE/4;
    CGFloat yPos = (6 - n_string) * STRING_GAP + TOP_MARGIN - MARKER_SIZE/2;
    
    if( fret == 0 )
        xPos = xPos - MARKER_SIZE/2;
    
    //    CALayer* layer = [ CALayer layer ];
    //    layer.frame = CGRectMake(10, 10, 20, 20);
    //    layer.backgroundColor = [ UIColor redColor ].CGColor;
    //    [ self.layer addSublayer:layer ];
    
    CATextLayer* textLayer = [ CATextLayer layer ];
    textLayer.string = [ self noteOnString:n_string fret:fret];
    //    textLayer.font = CFBridgingRetain( [ UIFont fontWithName:@"Helvetica-Neue" size:36]);
    textLayer.font = (__bridge CFTypeRef)(@"Helvetica-Neue");
    textLayer.fontSize = 15;
    
    textLayer.foregroundColor = [ UIColor blueColor ].CGColor;
    textLayer.opacity = 0.8;
    textLayer.frame = CGRectMake(xPos, yPos, MARKER_SIZE, MARKER_SIZE);
    [self.layer addSublayer:textLayer];
    [self.markers addObject:textLayer];
    
}

-(void)showNoteMarker:(NSUInteger)n_string fret:(NSUInteger)fret {
    const NSUInteger MARKER_RADIUS = STRING_GAP/3*2;
    
    CGFloat* fretConstants = [ FretMath fretConstants ];
    CGFloat Xfret0 = fretConstants[fret-1] * F2W_SCALE + MARGIN;
    CGFloat Xfret1 = fretConstants[fret] * F2W_SCALE + MARGIN;
    CGFloat xPos = Xfret0 + (Xfret1 - Xfret0)/2 - MARKER_RADIUS/2;
    CGFloat yPos = (6 - n_string) * STRING_GAP + TOP_MARGIN - MARKER_RADIUS/2;
    
    if( fret == 0 )
        xPos = xPos - MARKER_RADIUS/2;

    CATextLayer* layer = [ CATextLayer layer ];
    layer.cornerRadius = MARKER_RADIUS/2;
    layer.backgroundColor = [ UIColor orangeColor ].CGColor;
    layer.frame = CGRectMake(xPos, yPos, MARKER_RADIUS, MARKER_RADIUS);
    [self.layer addSublayer:layer];
    [self.markers addObject:layer];

}

-(void)showMarker:(NSUInteger)n_string fret:(NSUInteger)fret {

    const NSUInteger MARKER_RADIUS = STRING_GAP/3*2;
    
    CGFloat* fretConstants = [ FretMath fretConstants ];
    CGFloat Xfret0 = fretConstants[fret-1] * F2W_SCALE + MARGIN;
    CGFloat Xfret1 = fretConstants[fret] * F2W_SCALE + MARGIN;
    CGFloat xPos = Xfret0 + (Xfret1 - Xfret0)/2 - MARKER_RADIUS/2;
    CGFloat yPos = (6 - n_string) * STRING_GAP + TOP_MARGIN - MARKER_RADIUS/2;
    
    if( fret == 0 )
        xPos = xPos - MARKER_RADIUS/2;
    
    //    CALayer* layer = [ CALayer layer ];
    //    layer.frame = CGRectMake(10, 10, 20, 20);
    //    layer.backgroundColor = [ UIColor redColor ].CGColor;
    //    [ self.layer addSublayer:layer ];
    
    CATextLayer* layer = [ CATextLayer layer ];
    layer.cornerRadius = MARKER_RADIUS/2;
    layer.backgroundColor = [ UIColor orangeColor ].CGColor;
    layer.foregroundColor = [ UIColor redColor ].CGColor;
    layer.frame = CGRectMake( xPos, yPos, MARKER_RADIUS, MARKER_RADIUS );
    [ self.layer addSublayer:layer ];
    [ self.markers addObject:layer ];

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);

//    const CGFloat TOP_MARGIN = (self.frame.size.height - STRING_GAP * 7)/2;
    
    // 24.75 scale
    CGFloat f2wScale = (self.frame.size.width - MARGIN * 2) / NECK_LENGTH;
    
    CGFloat* fretConstants = [ FretMath fretConstants ];
    
    for( int i = 1; i < 7; ++i ) {
        CGContextMoveToPoint(context, MARGIN, TOP_MARGIN + i * STRING_GAP );
        /* And end it at this point */
        CGContextAddLineToPoint(context, self.frame.size.width - MARGIN, TOP_MARGIN + i * STRING_GAP);
        
    }
    

    
    for( int i = 0; i < NUMBER_OF_FRETS; ++i ) {
        CGFloat fretPos = f2wScale * fretConstants[i];
        CGContextMoveToPoint( context, fretPos + MARGIN, STRING_GAP + TOP_MARGIN );
        CGContextAddLineToPoint( context, fretPos + MARGIN, 6 * STRING_GAP + TOP_MARGIN );
    }

    CGContextStrokePath(context);
    
    NSInteger inlayIndices[] = { 3, 5, 7, 9, /*12,*/ 15, 17, 19, 21 };
    
    for( int i = 0; i < sizeof(inlayIndices)/sizeof(NSInteger); ++i ) {
        
        CGFloat fret1Pos = f2wScale * fretConstants[ inlayIndices[ i ] ] + MARGIN;
        CGFloat fret2Pos = f2wScale * fretConstants[ inlayIndices[i] - 1 ] + MARGIN;
        CGFloat dotPos = fret1Pos + (fret2Pos - fret1Pos)/2;
        CGFloat yPos = self.frame.size.height / 2;
        CGRect rect = CGRectMake( dotPos - DOT_RADIUS/2, yPos - DOT_RADIUS/2, DOT_RADIUS, DOT_RADIUS );
        CGContextSetFillColorWithColor(context, [ UIColor grayColor].CGColor);
        CGContextFillEllipseInRect ( context, rect );
    }
    
    // 12th freat inlay
    CGFloat fret12Pos = f2wScale * fretConstants[12] + MARGIN;
    CGFloat fret11Pos = f2wScale * fretConstants[11] + MARGIN;
    CGFloat xDotPos = fret11Pos + (fret12Pos - fret11Pos) / 2;
    CGFloat dot1YPos = self.frame.size.height/2 - 3/2 * STRING_GAP;
    CGFloat dot2YPos = self.frame.size.height/2 + 3/2 * STRING_GAP;
    CGRect dot1Rect = CGRectMake( xDotPos - DOT_RADIUS/2, dot1YPos - DOT_RADIUS/2, DOT_RADIUS, DOT_RADIUS );
    CGContextFillEllipseInRect ( context, dot1Rect );
    CGRect dot2Rect = CGRectMake( xDotPos - DOT_RADIUS/2, dot2YPos - DOT_RADIUS/2, DOT_RADIUS, DOT_RADIUS );
    CGContextFillEllipseInRect ( context, dot2Rect );

    CGContextFillPath(context);

}

-(NSMutableArray*)markers {
    if( _markers == nil ) {
        _markers = [[ NSMutableArray alloc ] init];
    }
    return _markers;
}
@end
