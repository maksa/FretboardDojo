//
//  FretboardView.h
//  FretboardDojo
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FretboardView : UIView
-(void)showMarker:(NSUInteger)string fret:(NSUInteger)fret;
-(NSArray*)allNotePositions:(NSString*)findnote;
-(void)clearMarkers;
@property (nonatomic) NSArray* notes;
@property (nonatomic) NSMutableArray* markers;

@end
