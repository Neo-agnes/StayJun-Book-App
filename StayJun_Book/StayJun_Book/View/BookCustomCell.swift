//  BookCustomCell.swift

import Foundation
import UIKit
import CoreData
import Then

// API로 불러온 각각의 테이블들의 대한 UI 배치와 데이터 표시
class BookCustomCell: UITableViewCell {
    let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let authorLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(priceLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bookImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 80),
            bookImageView.heightAnchor.constraint(equalToConstant: 120),

            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),

            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with book: BookModel) {
        titleLabel.text = book.title
        authorLabel.text = "저자: \(book.authors)"
        priceLabel.text = "가격: \(book.price)원"
        
        guard let url = URL(string: book.thumbnail) else {
            bookImageView.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.bookImageView.image = nil
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.bookImageView.image = image
            }
        }.resume()
    }
}
