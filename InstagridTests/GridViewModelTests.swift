//
//  GridViewModelTests.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 28/03/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//


@testable import Instagrid
import XCTest

final class GridViewModelTests: XCTestCase {
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex0_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .top)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 0)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex1_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .topLeft)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 1)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex2_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .topRight)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 2)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex3_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottomLeft)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 3)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex4_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottomRight)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 4)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectSpotAtIndex5_ThenSelectedSpotIsTopLeft() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottom)
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 5)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectSpotWithABigIndex_ThenNothingIsReturned() {
        let viewModel = GridViewModel()
        let expectation = self.expectation(description: "Returned Spot")
        expectation.isInverted = true
        
        viewModel.selectedSpot = { spot in
            XCTFail()
            expectation.fulfill()
        }
        
        viewModel.didSelectSpot(at: 10000000000000)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
