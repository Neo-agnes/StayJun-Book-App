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

    let cancelButton = UIButton().then {
        $0.setTitle("Cancel", for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 10
    }

    let saveButton = UIButton().then {
        $0.setTitle("Save", for: .normal)
        $0.backgroundColor = .green
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        loadDataIfNeeded()
    }

    private func addSubviews() {
        view.addSubview(bookNameLabel)
        view.addSubview(authorLabel)
        view.addSubview(bookImageView)
        view.addSubview(priceLabel)
        view.addSubview(cancelButton)
        view.addSubview(saveButton)
    }

    private func loadDataIfNeeded() {
        guard let book = book else { return }
        bookNameLabel.text = book.title
        authorLabel.text = "저자: \(book.authors)"
        priceLabel.text = "가격: \(book.price)원"
        loadBookImage(from: book.thumbnail)
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
        // Your NSLayoutConstraint.activate([...]) calls here
    }
}
