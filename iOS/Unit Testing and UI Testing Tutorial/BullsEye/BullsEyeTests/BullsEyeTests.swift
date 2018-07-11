//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by xin on 2018/7/10.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    var gameUnderTest: BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }
    
    override func tearDown() {
        gameUnderTest = nil;
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testScoreIsComputedWhenGuessGTTarget() {
        // 1. given
        let guess = gameUnderTest.targetValue + 5
        
        // 2. when
        _ = gameUnderTest.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }
    
    func testScoreIsComputedWhenGuessLTTarget() {
        // 1. given
        let guess = gameUnderTest.targetValue - 5
        
        // 2. when
        _ = gameUnderTest.check(guess: guess)
        
        // 3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
    }
    
}
