// SearchViewController.swift

import Foundation
import UIKit
import CoreData

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let recentBooksLabel = UILabel()
    let coverImageView = UIImageView()
    
    var searchResults: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        searchButton.addTarget(self, action: #selector(searchBooks), for: .touchUpInside)
        searchTextField.delegate = self
    }
    
    private func setupUI() {
        searchTextField.placeholder = "어떤 책이 필요하세요?"
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.borderColor = UIColor.black.cgColor
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .blue
        
        recentBooksLabel.text = "최근 본 책"
        recentBooksLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(recentBooksLabel)
        coverImageView.image = UIImage(named: "imageName")  // 사용하지 않으면 삭제하세요.
    }
    
    private func setupLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10)
        ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
        ])
        
        recentBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentBooksLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            recentBooksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentBooksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func searchBooks() {
            guard let searchText = searchTextField.text, !searchText.isEmpty else { return }
            showLoadingIndicator()
            fetchBooks(searchText: searchText) { [weak self] (books: [Book]?, error: Error?) in
                DispatchQueue.main.async {
                    self?.hideLoadingIndicator()
                    if let books = books {
                        for book in books {
                            self?.saveBook(title: book.title)
                        }
                        // Proceed with updating your UI
                    } else if let error = error {
                        self?.showErrorAlert(message: "Failed to fetch books: \(error.localizedDescription)")
                    }
                }
            }
        }


    func fetchBooks(searchText: String, completion: @escaping ([Book]?, Error?) -> Void) {
        let urlString = "https://dapi.kakao.com/v3/search/book?query=\(searchText)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil) as Error)
            return
        }

        var request = URLRequest(url: url)
        request.addValue("KakaoAK {YOUR_API_KEY}", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "HTTPError", code: -2, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let bookData = try decoder.decode(BookData.self, from: data)
                completion(bookData.books, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        for subview in self.view.subviews {
            if let activityIndicator = subview as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

extension SearchViewController: SearchBookViewDelegate {
    func presentAlert(from view: SearchBookView, withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension SearchViewController {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
