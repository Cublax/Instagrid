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
    func configure(with viewModelType: FirstGridViewModel, delegate: FirstGridDelegate)
}



final class GridViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var gridContainer: UIView!
    @IBOutlet weak var firstGridButton: UIButton!
    @IBOutlet weak var secondGridButton: UIButton!
    @IBOutlet weak var thirdGridButton: UIButton!
    
    private lazy var viewModel = GridViewModel()
    
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
    
    private func bind(to viewModel: GridViewModel) {
        
        viewModel.titleText = { [weak self] text in
            self?.title = text
        }
        
        viewModel.selectedConfiguration = { [weak self] choice in
            guard let self = self else { return }
            switch choice {
                
            case .firstGrid:
                self.currentGrid = FirstGrid()
                guard let currentGrid = self.currentGrid, let _currentGrid = currentGrid as? UIView else { return }
                let gridViewModel = FirstGridViewModel()
                currentGrid.configure(with: gridViewModel, delegate: self)
                _currentGrid.frame = self.gridContainer.bounds
                self.gridContainer.addSubview(_currentGrid)
                
            case .secondGrid:
                let grid = SecondGrid()
                let gridViewModel = SecondGridViewModel()
                grid.configure(with: gridViewModel, delegate: self)
                self.gridContainer.addSubview(grid)
                grid.frame = self.gridContainer.bounds
                grid.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
            case .thirdGrid:
                let grid = ThirdGrid()
                let gridViewModel = ThirdGridViewModel()
                grid.configure(with: gridViewModel, delegate: self)
                self.gridContainer.addSubview(grid)
                grid.frame = self.gridContainer.bounds
                grid.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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


extension GridViewController: FirstGridDelegate {
    func didTouchUpperLeftButton() {
      self.show(pickerController, sender: nil)
    }
    
    func didTouchUpperRightButton() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchBottomButton() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


extension GridViewController: SecondGridDelegate {
    func didTouchTopButton() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchBottomLeftButton() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchBottomRightButton() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension GridViewController: ThirdGridDelegate {
    func didTouchUpperLeftButtonThirdGrid() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchUpperRightButtonThirdGrid() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchBottomRightButtonThirdGrid() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTouchBottomLeftButtonThirdGrid() {
        let viewController = UIViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


extension GridViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             self.currentGrid?.set(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
