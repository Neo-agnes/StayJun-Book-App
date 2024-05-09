//
//  BookTableViewCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/10/24.
//

// 검색결과 뷰를 구성 하는곳
import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let thumbnailImageView = UIImageView()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(thumbnailImageView)
        addSubview(priceLabel)
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 100),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with book: BookModel) {
        titleLabel.text = book.title
        authorLabel.text = "저자: \(book.authors.joined(separator: ", "))"
        priceLabel.text = "가격: \(book.price)원"
        
        thumbnailImageView.image = nil // 재사용 전에 이미지를 클리어
        if let url = URL(string: book.thumbnail) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    // 셀의 이미지 뷰에 이미지를 설정하기 전에 URL이 여전히 동일한지 확인
                    if self.thumbnailImageView.image == nil {
                        self.thumbnailImageView.image = image
                    }
                }
            }
            task.resume()
        }
    }
}
