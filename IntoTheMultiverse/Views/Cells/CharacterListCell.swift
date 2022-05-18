//
//  CharacterListCell.swift
//  IntoTheMultiverse
//
//  Created by Roger Pintó Diaz on 5/18/22.
//

import UIKit
import Kingfisher

final class CharacterListCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let ivThumbnail = UIImageView()
    private let lblTitle = UILabel()
    private let constantMargin = Constants.UI.margin
    private let constantImageHeight = Constants.UI.cellImageHeight
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI methods
    
    private func setupImageView() {
        ivThumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ivThumbnail)
        
        ivThumbnail.contentMode = .scaleAspectFill
        ivThumbnail.clipsToBounds = true
        
        ivThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constantMargin).isActive = true
        ivThumbnail.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: constantMargin).isActive = true
        ivThumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constantMargin).isActive = true
        ivThumbnail.widthAnchor.constraint(equalToConstant: constantImageHeight).isActive = true
        
        let heightConstraint = ivThumbnail.heightAnchor.constraint(equalToConstant: constantImageHeight)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    private func setupTitleLabel() {
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lblTitle)
        
        lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: ivThumbnail.rightAnchor, constant: constantMargin).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        lblTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -constantMargin).isActive = true
    }
    
    // MARK: - Methods
    
    func setup(with viewModel: CharacterListCellViewModel) {
        ivThumbnail.kf.setImage(with: viewModel.thumbnailURL)
        lblTitle.text = viewModel.title
    }
}
