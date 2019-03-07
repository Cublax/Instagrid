//
//  ThirdGrid.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

protocol ThirdGridDelegate: class {
    func didTouchUpperLeftButtonThirdGrid()
    func didTouchUpperRightButtonThirdGrid()
    func didTouchBottomRightButtonThirdGrid()
    func didTouchBottomLeftButtonThirdGrid()
}

final class ThirdGrid: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var upperLeftPictureView: UIView!
    @IBOutlet weak var upperLeftButton: UIButton!
    
    
    @IBOutlet weak var upperRightPictureView: UIView!
    @IBOutlet weak var upperRightButton: UIButton!
    
    
    @IBOutlet weak var bottomRightPictureView: UIView!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    
    @IBOutlet weak var bottomLeftPictureView: UIView!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    
    private var viewModel: ThirdGridViewModel!
    
    private weak var delegate: ThirdGridDelegate?
    
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
        Bundle(for: type(of: self)).loadNibNamed("ThirdGrid", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    
    // MARK: - Configure
    
    func configure(with viewModel: ThirdGridViewModel, delegate: ThirdGridDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        bind(to: self.viewModel)
        self.viewModel.didConfigure()
    }
    
    private func bind(to viewModel: ThirdGridViewModel) {
        viewModel.chosenPicture = { [weak self] choice in
            switch choice {
            case .upperLeft:
                self?.delegate?.didTouchUpperLeftButtonThirdGrid()
            case .upperRight:
                self?.delegate?.didTouchUpperRightButtonThirdGrid()
            case .bottomLeft:
                self?.delegate?.didTouchBottomLeftButtonThirdGrid()
            case .bottomRight:
                self?.delegate?.didTouchBottomRightButtonThirdGrid()
            }
        }
    }
    
    func set(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = upperLeftPictureView.bounds
        upperLeftPictureView.addSubview(imageView)
    }
    
    
    // MARK: View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Actions
    
    
    @IBAction func didPressUpperLeftButton(_ sender: UIButton) {
        viewModel.didPressUpperLeft()
    }
    
    @IBAction func didPressUpperRightButton(_ sender: UIButton) {
        viewModel.didPressBottomRight()
    }
    
    @IBAction func didPressBottomRightButton(_ sender: UIButton) {
        viewModel.didPressBottomRight()
    }
    
    @IBAction func didPressBottomLeftButton(_ sender: UIButton) {
        viewModel.didPressBottomLeft()
    }
    
    
}
