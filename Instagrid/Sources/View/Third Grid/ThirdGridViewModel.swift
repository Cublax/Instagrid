//
//  ThirdGridViewModel.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

final class ThirdGridViewModel {
    
    enum PictureChoice {
        case upperLeft
        case upperRight
        case bottomLeft
        case bottomRight
    }
    
    var chosenPicture: ((PictureChoice) -> Void)?
    
    func didConfigure() {
        
    }
    
    func didPressUpperLeft() {
        chosenPicture?(.upperLeft)
    }
    
    func didPressUpperRight() {
        chosenPicture?(.upperRight)
    }
    
    func didPressBottomLeft() {
        chosenPicture?(.bottomLeft)
    }
    
    func didPressBottomRight() {
        chosenPicture?(.bottomRight)
    }
    
    
}
