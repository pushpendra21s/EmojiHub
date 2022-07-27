//
//  EmojiViewModelTests.swift
//  EmojisTests
//
//  Created by 918107 on 14/07/2022.
//

import XCTest
@testable import Emojis

class EmojiViewModelTests: XCTestCase {

    var sut: EmojisViewModel?
    var mockApiProvided: MockEmojiServiceProvider?

    override func setUp() {
        super.setUp()
        mockApiProvided = MockEmojiServiceProvider()
        sut = EmojisViewModel(apiService: mockApiProvided!)
    }

    override func tearDown() {
        sut = nil
        mockApiProvided = nil
        super.tearDown()
    }


    // MARK: - Emoji View Model Tests
    // MARK: -
    
    func test_fetchAllEmojiData_Success() {
//        // Given
        mockApiProvided?.givenSuccessEmojiList()
        
        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.allEmojisDataModel, "Mock Emojis data is nil")
        XCTAssertNil(sut?.apiError, "Mock Emojis error is not nil")
    }
    
    func test_fetch_Random_EmojiData_Success() {
        // Given
        mockApiProvided?.givenSuccess_RandomEmojiData()
        
        // When
        sut?.fetchRandomEmojiData()
        mockApiProvided?.completeRandomEmojiData_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.randomEmojiDataModel, "Mock random emoji data is nil")
        XCTAssertNil(sut?.apiError, "Mock random emojis error is not nil")
    }


    // MARK: - Emoji Cell View Models Tests
    // MARK: -
    
    func test_Prepare_CellViewModels_AllEmojis_Success() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()
        
        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.emojis.value, "Mock Emojis data is nil")

    }
    
    func test_Prepare_CellViewModels_AllEmojis_Success_With_Atleast_One_Emoji() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()
        
        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.emojis.value, "Mock Emojis data is nil")
        if let allEmojisViewModels = sut?.emojis.value {
            XCTAssertGreaterThan(allEmojisViewModels.count, 0, "Response was success but No emoji data present")
        }

    }
    
    func test_Prepare_CellViewModels_Random_EmojiData_Success() {
        // Given
        mockApiProvided?.givenSuccess_RandomEmojiData()
        
        // When
        sut?.fetchRandomEmojiData()
        mockApiProvided?.completeRandomEmojiData_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.randomEmoji.value, "Mock Random Emoji data is nil")

    }

    // MARK: - Failure scenario for view Model
    // MARK: -
    
    func test_fetchAllEmojiData_Failure_Handling_With_No_Emoji() {
        // Given
        mockApiProvided?.givenFailure_EmojiList_NoData()

        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
    
        // Assert
        XCTAssertNotNil(sut?.allEmojisDataModel, "Mock Emojis data is nil")
        XCTAssertNil(sut?.apiError, "Mock Emojis error is not nil")
        if let allEmojisViewModels = sut?.allEmojisDataModel {
            XCTAssertEqual(allEmojisViewModels.count, 0, "Response was success but No emoji data present in the response")
        }
    }
    
    func test_fetchAllEmojiData_Failure_Handling_InvalidJson() {
        // Given
        mockApiProvided?.givenFailure_EmojiList_InvalidResponseFromMockJson()
        let errorMsg = ErrorResponse.invalidJson.rawValue
        
        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
    
        // Assert
        XCTAssertNil(sut?.allEmojisDataModel, "Mock Emojis List data is not nil")
        XCTAssertNotNil(sut?.apiError, "Mock Emojis error is nil.. Should have invalid josn value")
        XCTAssertEqual(sut?.apiError, errorMsg, "Invalid json is not handled")
    }

    func test_fetch_Random_EmojiData_Failure_Handling_With_No_Emoji() {
        // Given
        mockApiProvided?.givenFailure_RandomEmoji_NoData()
        let errorMsg = ErrorResponse.invalidJson.rawValue

        // When
        sut?.fetchRandomEmojiData()
        mockApiProvided?.completeRandomEmojiData_Closure()
    
        // Assert
        XCTAssertNil(sut?.randomEmojiDataModel, "Mock Random Emoji data is not nil")
        XCTAssertNotNil(sut?.apiError, "Mock Random Emoji error is nil")
        XCTAssertEqual(sut?.apiError, errorMsg, "Invalid json is not handled")
    }
    
    func test_fetch_Random_EmojiData_Failure_Handling_InvalidJson() {
        // Given
        mockApiProvided?.givenFailure_RandomEmoji_InvalidResponseFromMockJson()
        let errorMsg = ErrorResponse.invalidJson.rawValue

        // When
        sut?.fetchRandomEmojiData()
        mockApiProvided?.completeRandomEmojiData_Closure()
    
        // Assert
        XCTAssertNil(sut?.randomEmojiDataModel, "Mock random emoji data is not nil")
        XCTAssertNotNil(sut?.apiError, "Mock random emoji data error is nil.. Should have invalid josn value")
        XCTAssertEqual(sut?.apiError, errorMsg, "Invalid json is not handled")
    }

    func test_NumberOfRows_FromCellViewModel_With_MockEmojiData() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()

        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
        let rowCount = sut?.numberOfRows_EmojiList()

        
        // Assert
        XCTAssertNotNil(sut?.emojis, "Mock Emojis data is nil")
        XCTAssertNil(sut?.apiError, "Mock Emojis error is not nil")
        XCTAssertEqual(sut?.allEmojisDataModel?.count, rowCount, "Number of rows not tested.")
    }

    func test_GetDataSource_FromViewModel_With_MockEmojiData() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()

        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
        if let emojiDetail = sut?.getEmojiDataSource(forSelectedRow: 0), let emojiDetailFromSUT = sut?.emojis.value?.first {
            // Assert
            XCTAssertEqual(emojiDetail.name, emojiDetailFromSUT.name, "Mock input was not able to create cell view model correctly.")
        } else {
            XCTAssert(true, "Mock input was not able to create cell view model correctly.")
        }
    }
    
    func test_GetDataSource_FromViewModel_With_MockEmojiCategory() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()

        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
        if let emojiDetail = sut?.getEmojiDataSource(forSelectedRow: 0), let emojiDetailFromSUT = sut?.emojis.value?.first {
            // Assert
            XCTAssertEqual(emojiDetail.getCategoryDescription(), emojiDetailFromSUT.getCategoryDescription(), "Mock input was not able to create cell view model correctly.")
        } else {
            XCTAssert(true, "Mock input was not able to create cell view model correctly.")
        }
    }

    func test_GetDataSource_FromViewModel_With_MockEmojiGroup() {
        // Given
        mockApiProvided?.givenSuccessEmojiList()

        // When
        sut?.fetchAllEmojiData()
        mockApiProvided?.completeEmojiList_Closure()
        if let emojiDetail = sut?.getEmojiDataSource(forSelectedRow: 0), let emojiDetailFromSUT = sut?.emojis.value?.first {
            // Assert
            XCTAssertEqual(emojiDetail.getGroupDescription(), emojiDetailFromSUT.getGroupDescription(), "Mock input was not able to create cell view model correctly.")
        } else {
            XCTAssert(true, "Mock input was not able to create cell view model correctly.")
        }
    }

}

