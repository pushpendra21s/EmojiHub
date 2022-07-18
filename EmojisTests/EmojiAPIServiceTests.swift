//
//  EmojiAPIServiceTests.swift
//  EmojisTests
//
//  Created by 918107 on 14/07/2022.
//

import XCTest
@testable import Emojis

class EmojiAPIServiceTests: XCTestCase {

    var sut: EmojiServiceProvider?
    
    override func setUp() {
        super.setUp()
        sut = EmojiServiceProvider()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Success scenario
    // MARK: - 
    func test_fetch_All_Emojis_API_SuccessRsponse() {
        let sut = self.sut!

        // Set an expectation that the call will be asynchronous and test has to wait untill further
        let expectation = XCTestExpectation(description: "callback")

        sut.fetchAllEmojis { (emojis, errorMsg) in
            expectation.fulfill()
            XCTAssertNil(errorMsg, "Error captured while fetching all the emojis")
            XCTAssertNotNil(emojis, "Emojis data is nil")
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_fetch_All_Emojis_API_Success_With_Atleast_One_Emoji() {
        // Given A apiservice
        let sut = self.sut!

        // Set an expectation that the call will be asynchronous and test has to wait untill further
        let expectation = XCTestExpectation(description: "callback")

        sut.fetchAllEmojis { (emojis, errorMsg) in
            expectation.fulfill()
            XCTAssertNil(errorMsg, "rror captured while fetching all the emojis")
            XCTAssertNotNil(emojis, "Emojis data is nil")
            if let allEmojis = emojis {
                XCTAssertGreaterThan(allEmojis.count, 0, "Response was success but No emoji data present")
            }
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_fetch_Random_Emojis_API_SuccessRsponse() {
        // Given A apiservice
        let sut = self.sut!

        // Set an expectation that the call will be asynchronous and test has to wait untill further
        let expectation = XCTestExpectation(description: "callback")

        sut.fetchRandomEmoji { (emoji, errorMsg) in
            expectation.fulfill()
            XCTAssertNil(errorMsg, "Error captured while fetching random emoji information")
            XCTAssertNotNil(emoji, "Random emoji data is nil")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    // MARK: - Failure scenario
    // MARK: -
    func test_fetch_All_Emojis_API_FailureRsponse_WithInvalidEndPoint() {
        // Given
        let sut = self.sut!
        let apiInvalidEndPoint = "invalid_testEndPoint"
        
        // Set an expectation that the call will be asynchronous and test has to wait untill further
        let expectation = XCTestExpectation(description: "callback")

        // When
        sut.fetchAllEmojis(allEmojiEndPoint: apiInvalidEndPoint) { (emojis, errorMsg) in
            expectation.fulfill()
            // Then
            XCTAssertNotNil(errorMsg, "When API does not return valid josn response, the error is not sent back.")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test_fetch_Random_Emojis_API_FailureRsponse_WithInvalidEndPoint() {
        // Given A apiservice
        let sut = self.sut!
        let apiInvalidEndPoint = "invalid_testEndPoint"

        // Set an expectation that the call will be asynchronous and test has to wait untill further
        let expectation = XCTestExpectation(description: "callback")
        sut.fetchRandomEmoji(randomEmojiEndPoint: apiInvalidEndPoint) { (emoji, errorMsg) in
            expectation.fulfill()
            XCTAssertNotNil(errorMsg, "When API does not return valid josn response, the error is not sent back.")
            XCTAssertNil(emoji, "Random emoji data is nil")
        }
        wait(for: [expectation], timeout: 30)
    }

}
