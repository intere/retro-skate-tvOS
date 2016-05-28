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

    private let ERROR_SIZE = CGSize(width: 128, height: 128)
    
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
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.frontBackgroundTexture.size())
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.midBackgroundTexture.size())
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.farBackgroundTexture.size())
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.asphaltTexture.size())
    }

}

// MARK: - Obstacles

extension TextureManagerTest {

    func testGetObstacles() {
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.dumpsterTexture.size())
    }
}

// MARK: - Skater Animation Textures

extension TextureManagerTest {

    func testGetSkaterAnimation() {
        XCTAssertNotNil(TextureManager.sharedManager.skaterPushTextures)
        XCTAssertEqual(12, TextureManager.sharedManager.skaterPushTextures.count)
        for texture in TextureManager.sharedManager.skaterPushTextures {
            XCTAssertNotEqual(ERROR_SIZE, texture.size())
        }
    }

}