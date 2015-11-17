//
//  FretboardViewController.h
//  FretboardDojo
//
//  Created by Maksa on 1/31/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FretboardView.h"
#import "Position.h"
#import "Guitar.h"

@interface FretboardViewController : UIViewController
@property NSDate* startTime;
@property Guitar* guitar;
@property NSTimeInterval answerTime;
-(void)notePressed:(NSString*)note;
@property (nonatomic) FretboardView* fretboardView;
-(void)proposeRandomPositionHide;
-(void)proposePositionAtRandomIndexPath;
@property (nonatomic) Position* askedPosition;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;
@property (weak, nonatomic) IBOutlet UIButton *proposedNoteLabel;
@property (strong, nonatomic) NSArray<NSIndexPath*>* selectedSections;
@property BOOL cheat;
@end
