//
//  ViewController.h
//  FretboardDojo
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FretboardViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *buttonDistances;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sharpDistances;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *firstSharpSpacings;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *wholeNotes;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *halfNotes;
@property (nonatomic) FretboardViewController* fretboardViewController;
@property (weak, nonatomic) IBOutlet UILabel *correctLabel;

@end

