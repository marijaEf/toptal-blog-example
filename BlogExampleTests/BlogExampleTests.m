//
//  BlogExampleTests.m
//  BlogExampleTests
//
//  Created by Marija Efremova on 2/28/15.
//  Copyright (c) 2015 Marija Efremova. All rights reserved.
//
////////
// This sample is published as part of the blog article at www.toptal.com/blog
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface BlogExampleTests : XCTestCase

@end

@implementation BlogExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
