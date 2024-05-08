//
//  BookCustomCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//

import Foundation
import UIKit

class BookCustomCell: UICollectionViewCell {
    // 책 이미지를 표시할 이미지 뷰
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 책 제목을 표시할 레이블
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 책 저자를 표시할 레이블
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 책 가격을 표시할 레이블
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 이미지 뷰 및 레이블을 셀에 추가
        addSubview(bookImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(priceLabel)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            // 책 이미지 뷰
            bookImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            bookImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            // 책 제목 레이블
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            // 책 저자 레이블
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            // 책 가격 레이블
            priceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 각 UI 요소에 대한 데이터 설정 메서드
    func configure(with book: Book) {
        // 책 이미지 설정
        // bookImageView.image = book.image
        
        // 책 제목 설정
        titleLabel.text = book.title
        
        // 책 저자 설정
        authorLabel.text = "저자: \(book.author)"
        
//        // 책 가격 설정
//        priceLabel.text = "가격: \(book.price)"
    }
}
