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
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "ThirstySoftRegular", size: 30.0)
            titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBOutlet private weak var directionLabel: UILabel! {
        didSet {
            directionLabel.font = UIFont(name: "Arial", size: 50.0)
            directionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBOutlet private weak var swipeDirectionLabel: UILabel! {
        didSet {
            swipeDirectionLabel.font = UIFont(name: "Delm-Medium", size: 25.0)
            swipeDirectionLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @IBOutlet private weak var gridContainer: UIView!
    @IBOutlet private weak var firstGridButton: UIButton!
    @IBOutlet private weak var secondGridButton: UIButton!
    @IBOutlet private weak var thirdGridButton: UIButton!
    
    // MARK: - Private properties
    
    private lazy var viewModel = HomeViewModel()
    
    private lazy var pickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = false
        return pickerController
    }()
    
    private lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(addSwipeGesture(_:)))
        swipeGesture.direction = .left
        return swipeGesture
    }()
    
    private lazy var upSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(addSwipeGesture(_:)))
        swipeGesture.direction = .up
        return swipeGesture
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
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
    
    // MARK: - Helpers
    
    @objc func addSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        UIView.transition(with: gridContainer,
                          duration: 0.5,
                          options: sender.direction == .left ? [.transitionFlipFromLeft] : [.transitionCurlUp],
                          animations: {},
                          completion: { [weak self] _ in self?.sharePicture() })
    }
    
    private func sharePicture() {
        UIGraphicsBeginImageContext(gridContainer.frame.size)
        gridContainer.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    private func configureContainer(for grid: GridType) {
        self.currentGrid = grid
        guard let gridView = grid as? UIView else { return }
        self.gridContainer.removeAllSubviews()
        self.gridContainer.layoutIfNeeded()
        gridView.frame = self.gridContainer.bounds
        self.gridContainer.addSubview(gridView)
    }
    
    // MARK: - Trait Collection
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        gridContainer.gestureRecognizers?.removeAll()
        if traitCollection.horizontalSizeClass == .compact, UIDevice.current.orientation == .portrait {
            gridContainer.addGestureRecognizer(upSwipeGestureRecognizer)
            viewModel.didChangeToCompact()
        } else {
            gridContainer.addGestureRecognizer(leftSwipeGestureRecognizer)
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
}

// MARK: - GridDelagate
extension HomeViewController: GridDelegate {
    func didSelect(spot: Spot) {
        self.currentSpot = spot
        self.show(pickerController, sender: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let spot = currentSpot {
            self.currentGrid?.set(image: image, for: spot)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
