//
//  BookCollectionViewCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

import Foundation
import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let coverImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil  // 이미지 재사용 문제 방지
        titleLabel.text = nil
        authorLabel.text = nil
    }

    private func setupViews() {
        coverImageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)

        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),

            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configure(with book: BookModel) {
        titleLabel.text = book.title
//        authorLabel.text = book.authors
//        loadImage(from: book.imageURL) // 이 부분은 아래에 구현
    }

    private func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        // 여기서 비동기적으로 이미지를 로드하고 셀에 설정
        // URLSession
    }
}
