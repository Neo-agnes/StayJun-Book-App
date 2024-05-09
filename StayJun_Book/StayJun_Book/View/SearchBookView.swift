//  SearchBookView.swift

// 책 상세 내역 모달 방식 적용하는 곳
import Foundation
import UIKit
import CoreData
import Then

class SearchBookView: UIViewController {
    var book: BookModel?  // 책 데이터를 받을 변수

    let bookNameLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }

    let authorLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .darkGray
    }

    let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }

    let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .blue
    }

    let contentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        return textView
    }()

    let cancelButton = UIButton().then {
        $0.setTitle("X", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 10
        $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    let saveButton = UIButton().then {
        $0.setTitle("담기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 10
        $0.widthAnchor.constraint(equalToConstant: 250).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        loadDataIfNeeded()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(bookNameLabel)
        view.addSubview(authorLabel)
        view.addSubview(bookImageView)
        view.addSubview(priceLabel)
        view.addSubview(contentsTextView)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
    }

    private func loadDataIfNeeded() {
        guard let book = book else { return }
        bookNameLabel.text = book.title
        authorLabel.text = "저자: \(book.authors)"
        priceLabel.text = "가격: \(book.price)원"
        loadBookImage(from: book.thumbnail)
        contentsTextView.text = book.contents
    }

    private func loadBookImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.bookImageView.image = image
                }
            }
        }.resume()
    }

    private func setupConstraints() {
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentsTextView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Book Name Label Constraints
            bookNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            // Author Label Constraints
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),

            // Book Image View Constraints
            bookImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            bookImageView.heightAnchor.constraint(equalToConstant: 200),

            // Price Label Constraints
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10),

            // Contents TextView Constraints
            contentsTextView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            contentsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentsTextView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20),

            // Cancel Button Constraints
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            // Save Button Constraints
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        // 코어 데이터에 도서를 저장하는 로직을 여기에 구현
    }
}
