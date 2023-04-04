//
//  ListTableViewCell.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 04.04.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let recipeTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.textColor = .systemGray
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        return textView
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 5
        button.setTitle("Подробнее...", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
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
        titleLabel.text = drink.strDrink
        recipeTextView.text = drink.strInstructions
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(recipeTextView)
        contentView.addSubview(moreButton)
        
            
        
    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            coctailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            coctailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            coctailImageView.heightAnchor.constraint(equalToConstant: 132),
            coctailImageView.widthAnchor.constraint(equalToConstant: 132),
            
            titleLabel.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 32),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            
            categoryLabel.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 32),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            recipeTextView.leadingAnchor.constraint(equalTo: coctailImageView.trailingAnchor, constant: 29),
            recipeTextView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            recipeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            recipeTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -72),
            
            moreButton.topAnchor.constraint(equalTo: recipeTextView.bottomAnchor, constant: 16),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            moreButton.heightAnchor.constraint(equalToConstant: 32),
            moreButton.widthAnchor.constraint(equalToConstant: 100)
           
        ])
    }
}



