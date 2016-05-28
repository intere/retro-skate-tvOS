//
//  TextureManagerTest.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/27/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import XCTest
@testable import RetroSkate

class TextureManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}

// MARK: - Background Texture Tests

extension TextureManagerTest {

    func testGetBackgrounds() {
        XCTAssertNotNil(TextureManager.sharedManager.bg1Texture)
        XCTAssertNotNil(TextureManager.sharedManager.bg2Texture)
        XCTAssertNotNil(TextureManager.sharedManager.bg3Texture)
        XCTAssertNotNil(TextureManager.sharedManager.asphaltTexture)
    }

}

// MARK: - Obstacles

extension TextureManagerTest {

    func testGetObstacles() {
        XCTAssertNotNil(TextureManager.sharedManager.dumpsterTexture)
    }
}

// MARK: - Skater Animation Textures

extension TextureManagerTest {

    func testGetSkaterAnimation() {
        XCTAssertNotNil(TextureManager.sharedManager.skaterAnimationTextures)
        XCTAssertEqual(12, TextureManager.sharedManager.skaterAnimationTextures.count)
    }

}