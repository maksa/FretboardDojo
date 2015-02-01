//
//  ViewController.m
//  FretboardDojo
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* wholeNoteBtn = self.wholeNotes[0];
    CGFloat screenwidth = self.view.frame.size.width;
    CGFloat availableSpace =  screenwidth - wholeNoteBtn.frame.size.width * 7 - 32;
    CGFloat spacing = availableSpace / 6;
//    spacing = 70;
    [self.buttonDistances enumerateObjectsUsingBlock:^(NSLayoutConstraint* cons, NSUInteger idx, BOOL *stop) {
        cons.constant = spacing;
    }];

    UIButton* halfNoteBtn = self.halfNotes[0];
    
    [self.firstSharpSpacings enumerateObjectsUsingBlock:^(NSLayoutConstraint* cons, NSUInteger idx, BOOL *stop) {
        cons.constant = spacing/2 - halfNoteBtn.frame.size.width/2;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onNote:(UIButton *)sender {
    static NSArray* notes;
    if( notes == nil )
        notes = @[ @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B" ];
    
    NSUInteger tag = sender.tag;
    [self.fretboardViewController notePressed:notes[tag]];

}
-(FretboardViewController*)fretboardViewController {
    return self.childViewControllers[0];
}

@end
