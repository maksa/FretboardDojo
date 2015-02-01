//
//  FretboardViewController.m
//  FretboardDojo
//
//  Created by Maksa on 1/31/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "FretboardViewController.h"
#import "Position.h"

@interface FretboardViewController ()

@end

@implementation FretboardViewController

-(void)proposeRandomPosition {
    self.startTime = [ NSDate new ];
    NSUInteger string = arc4random_uniform( 6 );
    NSUInteger fret = arc4random_uniform( 23 );
    Position* pos = [[ Position alloc ] initWithString:string fret:fret ];
    NSString* proposedNote = self.fretboardView.notes[string][fret];
    [ self.guitar play:proposedNote atPosition:pos ];
    [ self proposePosition:pos ];
}

-(void)proposePosition:(Position*)position {
    self.askedPosition = position;
    [self.fretboardView showMarker:position.string fret:position.fret];
    NSString* proposedNote = self.fretboardView.notes[position.string][position.fret];
    NSString* labelText = [ NSString stringWithFormat:@"%@ (%lu,%lu)", proposedNote, (unsigned long)position.string, (unsigned long)position.fret ];
    self.proposedNoteLabel.text = labelText;
}

-(void)markAllNotePositions:(NSString*)note {
    NSLog(@"Note pressed: %@", note );
    [self.fretboardView clearMarkers];
    NSArray* positions =  [self.fretboardView allNotePositions:note];
    [positions enumerateObjectsUsingBlock:^(Position* pos, NSUInteger idx, BOOL *stop) {
        [self.fretboardView showMarker:pos.string  fret:pos.fret];
    }];
}

-(void)handleGoodAnswer:(NSString*)note {
    NSDate* now = [ NSDate new ];
    self.answerTime = [ now timeIntervalSinceDate:self.startTime ];
    NSLog(@"guessed after %f seconds", self.answerTime );
    self.correctLabel.textColor = [UIColor colorWithRed:0.000 green:0.535 blue:0.000 alpha:1.000];
    self.correctLabel.text = @"Good!";
    [self.correctLabel sizeToFit];
    [self.fretboardView clearMarkers];
    [ self proposeRandomPosition ];
    
}

-(void)handleWrongAnswer:(NSString*)note {
    self.correctLabel.textColor = [ UIColor redColor];
    self.correctLabel.text = @"Wrong...";
    [self.correctLabel sizeToFit];
}

-(void)notePressed:(NSString*)note {
    NSString* noteAtAskedPosition = self.fretboardView.notes[self.askedPosition.string][self.askedPosition.fret];
    if( [note isEqualToString:noteAtAskedPosition ]) {
        [ self handleGoodAnswer:note ];
    } else {
        [ self handleWrongAnswer:note ];
    }
}
- (IBAction)replayNote:(UIButton *)sender {
    Position* pos = self.askedPosition;
    NSString* note = self.fretboardView.notes[pos.string][pos.fret];
    [ self.guitar play:note atPosition:pos];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guitar = [[ Guitar alloc ] init];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [self proposeRandomPosition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(FretboardView*)fretboardView {
    return (FretboardView*)self.view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
