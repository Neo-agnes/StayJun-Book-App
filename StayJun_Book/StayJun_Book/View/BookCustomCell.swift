//
//  BookCustomCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//

import Foundation
import UIKit

class BookCustomCell: UICollectionViewCell {
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(bookImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(priceLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            bookImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }

    func configure(with book: BookModel) {
        titleLabel.text = book.title
        authorLabel.text = "저자: \(book.author)"
        priceLabel.text = "\(book.price)원"
        loadImage(from: book.imageURL)
    }
    
    private func loadImage(from url: String) {
        // URLSession, SDWebImage 또는 Kingfisher 등을 사용하여 이미지 로드
    }
}
