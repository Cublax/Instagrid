//
//  FirstGrid.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 21/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

protocol FirstGridDelegate: class {
    func didTouchUpperLeftButton()
    func didTouchUpperRightButton()
    func didTouchBottomButton()
}


final class FirstGrid: UIView, GridType {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var upperLeftPictureView: UIView!
    @IBOutlet weak var upperLeftButton: UIButton!
    
    @IBOutlet weak var upperRightPictureView: UIView!
    @IBOutlet weak var upperRightButton: UIButton!
    
    @IBOutlet weak var bottomPictureView: UIView!
    @IBOutlet weak var bottomButton: UIButton!
    
    
    private var viewModel: FirstGridViewModel!
    
    private weak var delegate: FirstGridDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle(for: type(of: self)).loadNibNamed("FirstGrid", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - Configure
    
    func configure(with viewModel: FirstGridViewModel, delegate: FirstGridDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        bind(to: self.viewModel)
        self.viewModel.didConfigure()
    }
    
    private func bind(to viewModel: FirstGridViewModel) {
        viewModel.chosenPicture = { [weak self] choice in
            switch choice {
            case .upperLeft:
                self?.delegate?.didTouchUpperLeftButton()
            case .upperRight:
                self?.delegate?.didTouchUpperRightButton()
            case .bottom:
                self?.delegate?.didTouchBottomButton()
            }
        }
    }
    
    func set(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = upperLeftPictureView.bounds
        upperLeftPictureView.addSubview(imageView)
    }
    
    // MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressUpperLeftButton(_ sender: UIButton) {
        viewModel.didPressUpperLeft()
        
    }
    
    @IBAction func didPressUpperRightButton(_ sender: UIButton) {
        viewModel.didPressUpperRight()
    }
    
    @IBAction func didPressBottomButton(_ sender: UIButton) {
        viewModel.didPressBottom()
    }
}


