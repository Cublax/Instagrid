//
//  GridViewModel.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 07/03/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol GridDelegate: class {
    func didSelect(spot: Spot)
}

enum Spot: Int, CaseIterable {
    case top = 0
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case bottom
}

final class GridViewModel {
    
    // MARK: - Outputs
    
    var selectedSpot: ((Spot) -> Void)?
    
    // MARK: - Intputs
    
    func didSelectSpot(at index: Int) {
        guard let spot = Spot(rawValue: index) else {return}
        selectedSpot?(spot)
    }
}
