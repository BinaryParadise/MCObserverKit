//
//  MCObserverKitTests.m
//  MCObserverKitTests
//
//  Created by mylcode on 01/15/2018.
//  Copyright (c) 2018 mylcode. All rights reserved.
//

@import XCTest;

#import <MCObserverKit/MCObserverKit.h>
#import "MCTestModel.h"

@interface Tests : XCTestCase
@property (nonatomic, assign) BOOL other;
@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testValueChanged {
    XCTestExpectation *testExpectation = [self expectationWithDescription:@"异步改变2"];
    testExpectation.expectedFulfillmentCount = 3;
    MCTestModel *m1 = [MCTestModel new];
    [MCObserver(m1, uuid) valueChanged:^(id target, id value) {
        XCTAssert(m1.uuid == 15568);
        [testExpectation fulfill];
    }];
    [MCObserver(m1, text) valueChanged:^(id target, id value) {
        XCTAssert(value);
        [testExpectation fulfill];
    } condition:^BOOL(id target, id value) {
        return [value length] > 2;
    }];
    [MCObserver(m1, uuid) addTarget:m1 action:@selector(targetCallback:)];
    m1.uuid = 15568;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssert([m1.text isEqualToString:@"target test"]);
        [testExpectation fulfill];
    });
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (void)testNoneCallback {
    MCTestModel *m1 = [MCTestModel new];
    MCTestModel *m2 = [MCTestModel new];
    MOKObject *mo = MCObserver(m1, uuid1);
    MCBinding(m1, uuid) = mo;
    [self addObserver:mo forKeyPath:@"other" options:NSKeyValueObservingOptionNew context:nil];
    self.other = YES;
    m1.uuid1 = 200;
    m1.uuid = 100;
    XCTAssert(m1.uuid == 100);
    XCTAssert(m1.uuid1 == 100);
    MCBinding(m1, text) = MCObserver(m2, text);
    m1.text = @"xxx222";
    XCTAssert([m2.text isEqualToString:@"xxx222"]);
    m1.text = nil;
    XCTAssert([m2.text isEqual:[NSNull null]]);
}

- (void)testSingle
{
    MCTestModel *m1 = [MCTestModel new];
    MCTestModel *m2 = [MCTestModel new];
    MCBinding(m1, uuid) = MCObserver(m2, uuid);
    MCBinding(m1, text) = MCObserver(m2, text);
    m1.uuid = 15568;
    m1.uuid1 = 1111;
    m1.text = @"observer test text!";
    XCTAssertEqual(m1.uuid, m2.uuid);
    XCTAssertEqual(m2.text, m2.text);
}

- (void)testReversible {
    MCTestModel *m1 = [MCTestModel new];
    MCTestModel *m2 = [MCTestModel new];
    MCBinding(m1, uuid) = MCObserverCC(m2, uuid);
    MCBinding(m1, text) = MCObserverCC(m2, text);
    m1.uuid = 15568;
    m1.text = @"reversible observer test text!";
    XCTAssertEqual(m1.uuid, m2.uuid);
    XCTAssertEqual(m2.text, m2.text);
    m2.uuid = 16568;
    m2.text = @"xxxxxx";
    XCTAssert(m1.uuid == 16568);
    XCTAssert([m1.text isEqualToString:@"xxxxxx"]);
}

@end

