//
//  SearchBookView.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

// 책 상세 내역 모달 방식 적용
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
            priceLabel.text = "\(book.price)원"

            // 이미지 URL에서 이미지 로딩
            if let imageUrl = URL(string: book.thumbnail) {
                let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.bookImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bookNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            authorLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            bookImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            bookImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            bookImageView.heightAnchor.constraint(equalToConstant: 300),

            priceLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),

            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
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
