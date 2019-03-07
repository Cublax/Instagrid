//
//  ImageImport.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class ImageImporter: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //outlet
    var myImageView: UIImageView!
    
    //Action
    
    func importImage(_ sender: AnyObject) {
        
    let image = UIImagePickerController()
        image.delegate = self
        
    image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
    image.allowsEditing = false
        
        self.present(image, animated: true) {
            // After it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myImageView.image = image
        } else {
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
}
