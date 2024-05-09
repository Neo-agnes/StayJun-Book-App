//
//  SearchBookView.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

// 책 모달 뷰
import Foundation
import UIKit
import CoreData

class SearchBookView: UIViewController {
    var book: BookModel?  // 책 데이터를 받을 변수
    
    let bookNameLabel = UILabel()
    let authorLabel = UILabel()
    let bookImageView = UIImageView()
    let priceLabel = UILabel()
    let cancelButton = UIButton()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
    }

    private func setupUI() {
        if let book = book {
            bookNameLabel.text = book.title
            authorLabel.text = "저자: \(book.authors)"
//            bookImageView.loadImage(from: book.imageURL)
            priceLabel.text = "\(book.price)원"
        }
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }

    private func setupLayout() {
        let views = [bookNameLabel, authorLabel, bookImageView, priceLabel, cancelButton, saveButton]
        views.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // 이하 생략: 다른 컴포넌트들에 대한 오토레이아웃 설정
        ])
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc func saveAction() {
        NotificationCenter.default.post(name: NSNotification.Name("BookSaved"), object: nil, userInfo: ["book": book])
        dismiss(animated: true, completion: nil)
    }
}
