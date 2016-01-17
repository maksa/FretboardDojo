//
//  ViewController.m
//  FretboardDojo
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import "ViewController.h"
#import "FretMarkerCell.h"

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
    
    self.fretboardSections = [[ NSMutableSet alloc ] init];
    self.fretboardViewController.selectedSections = self.fretboardSections.allObjects;
    self.fretSelectCollectionView.allowsMultipleSelection = YES;
    
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 22;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = collectionView.bounds.size.width / 22;
    CGFloat h = 35;
    return CGSizeMake( w, h );
    
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FretMarkerCell* cell = [ collectionView dequeueReusableCellWithReuseIdentifier:@"fretcell" forIndexPath:indexPath ];
    
    UIView* selectedView = [[ UIView alloc ] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height )];

    selectedView.backgroundColor = [ UIColor blueColor ];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"klikete klik: %@", indexPath);
    [ self.fretboardSections addObject:indexPath ];
    self.fretboardViewController.selectedSections = self.fretboardSections.allObjects;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"deselektovao: %@", indexPath );
    [ self.fretboardSections removeObject:indexPath ];
    self.fretboardViewController.selectedSections = self.fretboardSections.allObjects;
}
-(IBAction)onDoneWithSettings:(UIStoryboardSegue*)exitSegue {
    
}
@end
