//
//  FirstGridViewModel.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 21/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation


final class FirstGridViewModel {
    
    enum PictureChoice {
        case upperLeft
        case upperRight
        case bottom
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
    
    func didPressBottom() {
        chosenPicture?(.bottom)
    }
}

