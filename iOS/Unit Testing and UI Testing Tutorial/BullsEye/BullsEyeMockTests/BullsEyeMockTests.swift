//
//  BullsEyeMockTests.swift
//  BullsEyeMockTests
//
//  Created by xin on 2018/7/11.
//  Copyright © 2018年 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class MockUserDefaults: UserDefaults {
    var gameStyleChanged = 0
    override func set(_ value: Int, forKey defaultName: String) {
        if defaultName == "gameStyle" {
            gameStyleChanged += 1
        }
    }
}

class BullsEyeMockTests: XCTestCase {
    
    var controllerUnderTest: ViewController!
    var mockUserDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        mockUserDefaults = MockUserDefaults(suiteName: "testing")!
        controllerUnderTest.defaults = mockUserDefaults
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        mockUserDefaults = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameStyleCanBeChanged() {
        // given
        let segmentControl = UISegmentedControl()
        
        // when
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 0, "gameStyleChanged should be 0 before sendActions")
        segmentControl.addTarget(controllerUnderTest, action: #selector(ViewController.chooseGameStyle(_:)), for: .valueChanged)
        segmentControl.sendActions(for: .valueChanged)
        
        // then
        XCTAssertEqual(mockUserDefaults.gameStyleChanged, 1, "gameStyle user default wasn't changed")
    }
    
}
