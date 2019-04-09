//
//  HomeViewModelTests.swift
//  InstagridTests
//
//  Created by Alexandre Quiblier on 05/04/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

@testable import Instagrid
import XCTest

final class HomeViewModelTests: XCTestCase {
    
    func testGivenHomeViewModel_WhenViewDidLoad_ThenTitleText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned title text")
        
        viewModel.titleText = { titleText in
            XCTAssertEqual(titleText, "Instagrid")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenViewDidLoad_ThenDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned direction text")
        
        viewModel.directionText = { direction in
            XCTAssertEqual(direction, "^")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenViewDidLoad_ThenSwipeDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned swipe-up")
        
        viewModel.swipeDirectionText = { directionIndication in
            XCTAssertEqual(directionIndication, "swipe-up")
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenViewDidLoad_ThenSelectedConfiguration() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned configuration")
        
        viewModel.selectedConfiguration = { configuration in
            XCTAssertEqual(configuration, .firstGrid)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidPressFirstGrid_ThenSelectedConfiguration() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned configuration")
        
        var counter = 0
        viewModel.selectedConfiguration = { configuration in
            if counter == 1 {
                XCTAssertEqual(configuration, .firstGrid)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressFirstGrid()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidPressSecondGrid_ThenSelectedConfiguration() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned configuration")
        
        var counter = 0
        viewModel.selectedConfiguration = { configuration in
            if counter == 1 {
                XCTAssertEqual(configuration, .secondGrid)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressSecondGrid()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidPressThirdGrid_ThenSelectedConfiguration() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned configuration")
        
        var counter = 0
        viewModel.selectedConfiguration = { configuration in
            if counter == 1 {
                XCTAssertEqual(configuration, .thirdGrid)
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didPressThirdGrid()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidChangeToCompact_ThenDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned directionText")
        
        var counter = 0
        viewModel.directionText = { directionText in
            if counter == 1 {
                XCTAssertEqual(directionText, "^")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didChangeToCompact()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidChangeToCompact_ThenSwipeDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned swipe share")
        
        var counter = 0
        viewModel.swipeDirectionText = { directionIndication in
            if counter == 1 {
                XCTAssertEqual(directionIndication, "swipe-up to share")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didChangeToCompact()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidChangeToRegular_ThenDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned directionText")
        
        var counter = 0
        viewModel.directionText = { directionText in
            if counter == 1 {
                XCTAssertEqual(directionText, "<")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didChangeToRegular()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenHomeViewModel_WhenDidChangeToRegular_ThenSwipeDirectionText() {
        let viewModel = HomeViewModel()
        let expectation = self.expectation(description: "returned swipe share")
        
        var counter = 0
        viewModel.swipeDirectionText = { directionIndication in
            if counter == 1 {
                XCTAssertEqual(directionIndication, "swipe-left to share")
                expectation.fulfill()
            }
            counter += 1
        }
        
        viewModel.viewDidLoad()
        
        viewModel.didChangeToRegular()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}



