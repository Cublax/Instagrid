//
//  GridViewController.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 15/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit



protocol GridType: class {
    func set(image: UIImage)
    func configure(with viewModelType: GridViewModel, delegate: GridDelegate)
}



final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var gridContainer: UIView!
    @IBOutlet weak var firstGridButton: UIButton!
    @IBOutlet weak var secondGridButton: UIButton!
    @IBOutlet weak var thirdGridButton: UIButton!
    
    private lazy var viewModel = HomeViewModel()
    
    private lazy var pickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        pickerController.allowsEditing = false
        return pickerController
    }()
    
    private var currentGrid: GridType?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: HomeViewModel) {
        
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.selectedConfiguration = { [weak self] choice in
            guard let self = self else { return }
            switch choice {
                
            case .firstGrid:
                self.currentGrid = FirstGrid()
                guard let currentGrid = self.currentGrid, let _currentGrid = currentGrid as? UIView else { return }
                let gridViewModel = GridViewModel()
                currentGrid.configure(with: gridViewModel, delegate: self)
                _currentGrid.frame = self.gridContainer.bounds
                self.gridContainer.addSubview(_currentGrid)
                
            case .secondGrid:
                break
                //let grid = SecondGrid()
                //let gridViewModel = gridViewModel()
                //grid.configure(with: gridViewModel, delegate: self)
                //self.gridContainer.addSubview(grid)
                //grid.frame = self.gridContainer.bounds
                //grid.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
            case .thirdGrid:
                break
                //let grid = ThirdGrid()
                //let gridViewModel = gridViewModel()
                //grid.configure(with: gridViewModel, delegate: self)
                //self.gridContainer.addSubview(grid)
                //grid.frame = self.gridContainer.bounds
                //grid.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            }
        }
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func didPressFirstGridButton(_ sender: UIButton) {
        viewModel.didPressFirstGrid()
    }
    
    @IBAction func didPressSecondGridButton(_ sender: UIButton) {
        viewModel.didPressSecondGrid()
    }
    
    @IBAction func didPressThirdGridButton(_ sender: UIButton) {
        viewModel.didPressThirdGrid()
    }
    
}


extension HomeViewController: GridDelegate {
    func didSelect(spot: Spot) {
        switch spot {
        case .top:
            break
        case .topLeft:
            break
        case .topRight:
            break
        case .bottomLeft:
            break
        case .bottomRight:
            break
        case .bottom:
            break
        }
        
        // Finaliser le code pour savoir quelle est l'image qui doit recevoir la photo selectionnée dans le controlleur.
        self.show(pickerController, sender: nil)
    }
    }



extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             self.currentGrid?.set(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
