//
//  ThirdGrid.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 27/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit



final class ThirdGrid: UIView, GridType {
    
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
    
    
    private var viewModel: GridViewModel!
    
    private weak var delegate: GridDelegate?
    
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
    
    func configure(with viewModel: GridViewModel, delegate: GridDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        bind(to: self.viewModel)
        self.viewModel.didConfigure()
    }
    
    private func bind(to viewModel: GridViewModel) {
        viewModel.selectedSpot = { [weak self] spot in
           self?.delegate?.didSelect(spot: spot)
        }
    }
    
    func set(image: UIImage, for spot: Spot) {
        let imageView = UIImageView(image: image)
        switch spot {
        case .topLeft:
            clearSubviews(of: upperLeftButton)
            imageView.frame = upperLeftPictureView.bounds
            upperLeftPictureView.addSubview(imageView)
        case .topRight:
            clearSubviews(of: upperRightPictureView)
            imageView.frame = upperRightPictureView.bounds
            upperRightPictureView.addSubview(imageView)
        case .bottomLeft:
            clearSubviews(of: bottomLeftPictureView)
            imageView.frame = bottomLeftPictureView.bounds
            bottomLeftPictureView.addSubview(imageView)
        case.bottomRight:
            clearSubviews(of: bottomRightPictureView)
            imageView.frame = bottomRightPictureView.bounds
            bottomRightPictureView.addSubview(imageView)
        default:
            break
        }
        imageView.frame = upperLeftPictureView.bounds
        upperLeftPictureView.addSubview(imageView)
    }
    
    private func clearSubviews(of view: UIView) {
        view.subviews.forEach{ $0.removeFromSuperview() }
    }
    
    // MARK: View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: Actions
    
    
    @IBAction func SelectSpot(_ sender: UIButton) {
        viewModel.didSelectSpot(at: sender.tag)
    }
    
    
}
