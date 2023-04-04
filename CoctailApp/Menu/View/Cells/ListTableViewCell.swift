//
//  ListTableViewCell.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 04.04.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let coctailTitleLabel: UILabel = {
        let coctailTitleLabel = UILabel()
        coctailTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        coctailTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        coctailTitleLabel.textColor = .black
        return coctailTitleLabel
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.textColor = .darkGray
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 15)
        return categoryLabel
    }()
    
    private let coctailInstructionTextView: UITextView = {
        let coctailInstructionTextView = UITextView()
        coctailInstructionTextView.font = UIFont.systemFont(ofSize: 13)
        coctailInstructionTextView.textColor = .systemGray
        coctailInstructionTextView.textAlignment = .left
        coctailInstructionTextView.translatesAutoresizingMaskIntoConstraints = false
        coctailInstructionTextView.isSelectable = false
        return coctailInstructionTextView
    }()
    
    private let priceButton: UIButton = {
        let priceButton = UIButton()
        priceButton.layer.borderWidth = 1
        priceButton.layer.borderColor = UIColor.red.cgColor
        priceButton.layer.cornerRadius = 5
        priceButton.setTitle("от 345 р", for: .normal)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
       // priceButton.setTitleColor(UIColor.standardPink, for: .normal)
        priceButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return priceButton
    }()
    
    private let coctailImageView: UIImageView = {
        let coctailImageView = UIImageView()
        coctailImageView.clipsToBounds = true
        coctailImageView.layer.cornerRadius = 132 / 2
        coctailImageView.contentMode = .scaleToFill
        coctailImageView.translatesAutoresizingMaskIntoConstraints = false
        return coctailImageView
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        configureUI()
        layout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withDrink drink: Drink) {
        coctailTitleLabel.text = drink.strDrink
        coctailInstructionTextView.text = drink.strInstructions
        categoryLabel.text = "Category: \(drink.strCategory!)"
        
        if let data = drink.drinkThumbImageData,
           let image = UIImage(data: data) {
            coctailImageView.image = image
        }
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
    }
    
    private func layout() {
        contentView.addSubview(coctailImageView)
        contentView.addSubview(coctailTitleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(coctailInstructionTextView)
        contentView.addSubview(priceButton)
        
            
        
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            coctailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coctailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            coctailImageView.heightAnchor.constraint(equalToConstant: 132),
            coctailImageView.widthAnchor.constraint(equalToConstant: 132),
            
            coctailTitleLabel.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 32),
            coctailTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            
            categoryLabel.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 32),
            categoryLabel.topAnchor.constraint(equalTo: coctailTitleLabel.bottomAnchor, constant: 7),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            coctailInstructionTextView.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 29),
            coctailInstructionTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            coctailInstructionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            coctailInstructionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -72),
            
            priceButton.topAnchor.constraint(equalTo: coctailInstructionTextView.bottomAnchor, constant: 16),
            priceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            priceButton.heightAnchor.constraint(equalToConstant: 32),
            priceButton.widthAnchor.constraint(equalToConstant: 87)
           
        ])
    }
}



