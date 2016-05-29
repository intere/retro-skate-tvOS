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

    func testGetCoinTexture() {
        XCTAssertNotEqual(ERROR_SIZE, TextureManager.sharedManager.coinTexture.size())
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

    func testGetSkaterCrashAnimation() {
        XCTAssertNotNil(TextureManager.sharedManager.skaterCrashTextures)
        XCTAssertEqual(12, TextureManager.sharedManager.skaterPushTextures.count)
        for texture in TextureManager.sharedManager.skaterPushTextures {
            XCTAssertNotEqual(ERROR_SIZE, texture.size())
        }
    }

    func testGetSkaterHardflipAnimation() {
        XCTAssertNotNil(TextureManager.sharedManager.skaterHardflipTextures)
        XCTAssertEqual(12, TextureManager.sharedManager.skaterHardflipTextures.count)
        for texture in TextureManager.sharedManager.skaterHardflipTextures {
            XCTAssertNotEqual(ERROR_SIZE, texture.size())
        }
    }

    func testGetSkaterOllieAnimation() {
        XCTAssertNotNil(TextureManager.sharedManager.skaterOllieTextures)
        XCTAssertEqual(10, TextureManager.sharedManager.skaterOllieTextures.count)
        for texture in TextureManager.sharedManager.skaterOllieTextures {
            XCTAssertNotEqual(ERROR_SIZE, texture.size())
        }
    }

}