//
//  UIKit + UIView.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/03/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Remove all subviews from currentview
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
