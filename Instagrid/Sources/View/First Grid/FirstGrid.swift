//
//  FirstGrid.swift
//  Instagrid
//
//  Created by Alexandre Quiblier on 21/02/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class FirstGrid: UIView, GridType {
    
    // MARK: - Outlets
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private weak var upperLeftPictureView: UIView!
    @IBOutlet private weak var upperLeftButton: UIButton!
    
    @IBOutlet private weak var upperRightPictureView: UIView!
    @IBOutlet private weak var upperRightButton: UIButton!
    
    @IBOutlet private weak var bottomPictureView: UIView!
    @IBOutlet private weak var bottomButton: UIButton!
    
    // MARK: - Private properties
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
        Bundle(for: type(of: self)).loadNibNamed(String(describing: FirstGrid.self),
                                                 owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: GridViewModel, delegate: GridDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        bind(to: self.viewModel)
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
            upperLeftPictureView.removeAllSubviews()
            imageView.frame = upperLeftPictureView.bounds
            upperLeftPictureView.addSubview(imageView)
        case .topRight:
            upperRightPictureView.removeAllSubviews()
            imageView.frame = upperRightPictureView.bounds
            upperRightPictureView.addSubview(imageView)
        case .bottom:
            bottomPictureView.removeAllSubviews()
            imageView.frame = bottomPictureView.bounds
            bottomPictureView.addSubview(imageView)
        default:
            break
        }
    }
    
    // MARK: - Actions
    
    @IBAction func selectedSpot(_ sender: UIButton) {
        viewModel.didSelectSpot(at: sender.tag)
    }
}
