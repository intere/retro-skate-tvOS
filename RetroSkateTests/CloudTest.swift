//
//  CloudTest.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/29/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import XCTest
@testable import RetroSkate

class CloudTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}

// MARK: - Y Position Tests

extension CloudTest {

    func testValidYPosition() {
        let cloud = Cloud()

        for _ in 0..<1000 {
            XCTAssertTrue(cloud.yPos <= 750, "The Y Position is higher than it should be")
            XCTAssertTrue(cloud.yPos >= 400, "The Y Position is lower than it should be")
        }
    }

}
