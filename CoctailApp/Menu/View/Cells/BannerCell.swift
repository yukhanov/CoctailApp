//
//  BannerCell.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    static let identifier = "BannerCell"
    
    private var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.image = UIImage(named: "banner")
        bannerImageView.contentMode = .scaleToFill
        bannerImageView.clipsToBounds = true
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.layer.cornerRadius = 15
        bannerImageView.backgroundColor = .clear
        return bannerImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(bannerImageView)
     
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
