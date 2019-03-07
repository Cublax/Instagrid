//
//  SecondGridViewModel.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation



final class SecondGridViewModel {
    
    enum PictureChoice {
        case top
        case bottomLeft
        case bottomRight
    }
    
    var chosenPicture: ((PictureChoice) -> Void)?
    
    func didConfigure() {
        
    }
    
    func didPressTop() {
        chosenPicture?(.top)
    }
    
    func didPressBottomLeft() {
        chosenPicture?(.bottomLeft)
    }
    
    func didPressBottomRight() {
        chosenPicture?(.bottomRight)
    }
    
}
