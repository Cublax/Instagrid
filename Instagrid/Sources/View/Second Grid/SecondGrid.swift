//
//  SecondGrid.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

protocol SecondGridDelegate: class {
    func didTouchTopButton()
    func didTouchBottomLeftButton()
    func didTouchBottomRightButton()
}

final class SecondGrid: UIView {
    
    
    // MARK: - Outlets
    
    @IBOutlet var contentView:UIView!
    
    @IBOutlet weak var topPictureView: UIView!
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet weak var bottomRightPictureView: UIView!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    @IBOutlet weak var bottomLeftPictureView: UIView!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    
    private var viewModel: SecondGridViewModel!
    
    private weak var delegate: SecondGridDelegate?
    
    
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
        Bundle(for: type(of: self)).loadNibNamed("SecondGrid", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: SecondGridViewModel, delegate: SecondGridDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        bind(to: self.viewModel)
        self.viewModel.didConfigure()
    }
    
    private func bind(to viewModel: SecondGridViewModel) {
        viewModel.chosenPicture = { [weak self] choice in
            switch choice {
            case .top:
                self?.delegate?.didTouchTopButton()
            case .bottomLeft:
                self?.delegate?.didTouchBottomLeftButton()
            case .bottomRight:
                self?.delegate?.didTouchBottomRightButton()
            }
        }
    }
    
    func set(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = topPictureView.bounds
        topPictureView.addSubview(imageView)
    }
    
    
    // MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressTopButton(_ sender: UIButton) {
        viewModel.didPressTop()
    }
    
    @IBAction func didPressBottomLeftButton(_ sender: UIButton) {
        viewModel.didPressBottomLeft()
    }
    
    
    @IBAction func didPressBottomRightButton(_ sender: UIButton) {
        viewModel.didPressBottomRight()
    }
    
}
