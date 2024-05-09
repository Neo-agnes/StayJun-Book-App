//
//  BookDetailViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//
import Foundation
import UIKit
import CoreData

class BookDetailViewController: UIViewController {
    var book: BookModel?
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configureView()
    }
    
    func configureView() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = "저자: \(book.authors.joined(separator: ", "))"
        
        if let imageUrl = URL(string: book.thumbnail) {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
// SearchViewController.swift
//extension SearchViewController {
//    func showBookDetails(_ book: BookModel) {
//        let detailVC = BookDetailViewController()
//        detailVC.book = book
//        navigationController?.pushViewController(detailVC, animated: tru                                e)
//    }
//}
