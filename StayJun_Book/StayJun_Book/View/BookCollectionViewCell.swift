//
//  BookCollectionViewCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

import Foundation
import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    // UI 컴포넌트 정의
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

    private func setupViews() {
        // 뷰 구성, 레이아웃 설정
        coverImageView.contentMode = .scaleAspectFit
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)

        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        // 오토레이아웃 설정
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

    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author  // 'author'를 사용
//        coverImageView.image = UIImage(named: book.coverImage)
    }
}
//class Book {
//    var title: String
//    var coverImage: String
//    var author: String  // 'author' 속성 추가
//
//    init(title: String, coverImage: String, author: String) {
//        self.title = title
//        self.coverImage = coverImage
//        self.author = author  // 초기화
//    }
//}
