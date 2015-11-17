//
//  FretboardDojoTests.m
//  FretboardDojoTests
//
//  Created by Maksa on 1/30/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FretboardView.h"

@interface FretboardDojoTests : XCTestCase

@end

@implementation FretboardDojoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    FretboardView* v = [[ FretboardView alloc ] init];
    NSLog( @"%@", v.notes );
}

@end
