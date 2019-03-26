//
//  GridViewModel.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 15/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    enum PictureConfiguration {
        case firstGrid, secondGrid, thirdGrid
    }
    
    // MARK: - Properties

    
    // MARK: - Initialisation
    
    // MARK: - Output
    
    
    var titleText: ((String) -> Void)?
    
    var directionText: ((String) -> Void)?
    
    var swipeDirectionText: ((String) -> Void)?
    
    var selectedConfiguration: ((PictureConfiguration) -> Void)?
    
    
    // MARK: - Input
    
    func viewDidLoad() {
        titleText?("Instagrid")
        directionText?("^")
        swipeDirectionText?("swipe-up")
        
    }
    
    func didPressFirstGrid() {
        selectedConfiguration?(.firstGrid)
        
    }
    
    func didPressSecondGrid() {
        selectedConfiguration?(.secondGrid)
    }
    
    func didPressThirdGrid() {
        selectedConfiguration?(.thirdGrid)
    }
    
    func didSwipe() {
        
    }
    
    func didChangeToCompact() {
        directionText?("^")
        swipeDirectionText?("swipe-up to share")
    }
    
    func didChangeToRegular() {
        directionText?("<")
        swipeDirectionText?("swipe-left")
    }
    
}
