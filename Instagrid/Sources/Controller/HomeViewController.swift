//
//  GridViewController.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 15/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit



protocol GridType: class {
    func set(image: UIImage, for spot: Spot)
    func configure(with viewModelType: GridViewModel, delegate: GridDelegate)
}



final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "ThirstySoftRegular", size: 30.0)
            titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBOutlet weak var directionLabel: UILabel! {
        didSet {
            directionLabel.font = UIFont(name: "Arial", size: 50.0)
            directionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBOutlet weak var swipeDirectionLabel: UILabel! {
        didSet {
            swipeDirectionLabel.font = UIFont(name: "Delm-Medium", size: 25.0)
            swipeDirectionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
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
    
    private var currentGrid: GridType? {
        didSet {
            let viewModel = GridViewModel()
            self.currentGrid?.configure(with: viewModel, delegate: self)
        }
    }
    
    private var currentSpot: Spot?
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    private func bind(to viewModel: HomeViewModel) {
        
        viewModel.titleText = { [weak self] text in
            self?.titleLabel.text = text
        }
        
        viewModel.selectedConfiguration = { [weak self] choice in
            guard let self = self else { return }
            switch choice {
                
            case .firstGrid:
                let gridType = FirstGrid()
                self.configureContainer(for: gridType)
            case .secondGrid:
                let gridType = SecondGrid()
                self.configureContainer(for: gridType)
            case .thirdGrid:
                let gridType = ThirdGrid()
                self.configureContainer(for: gridType)
            }
        }
        
        viewModel.swipeDirectionText = { [weak self] text in
            self?.swipeDirectionLabel.text = text
        }
        
        viewModel.directionText = { [weak self] text in
            self?.directionLabel.text = text
        }
    }
    
    private func configureContainer(for grid: GridType) {
        self.currentGrid = grid
        guard let gridView = grid as? UIView else { return }
        self.gridContainer.subviews.forEach { $0.removeFromSuperview() }
        gridView.frame = self.gridContainer.bounds
        self.gridContainer.addSubview(gridView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass == .compact && UIDevice.current.orientation == .portrait {
            viewModel.didChangeToCompact()
        } else {
            viewModel.didChangeToRegular()
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
    
    @IBAction func didSwipeGrid(_ sender: UISwipeGestureRecognizer) {
        viewModel.didSwipe()
        
    }
    
    
}


extension HomeViewController: GridDelegate {
    func didSelect(spot: Spot) {
        self.currentSpot = spot
        self.show(pickerController, sender: nil)
    }
}


extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let spot = currentSpot {
            self.currentGrid?.set(image: image, for: spot)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
