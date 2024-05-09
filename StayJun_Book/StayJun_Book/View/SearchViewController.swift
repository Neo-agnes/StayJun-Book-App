// SearchViewController.swift

import Foundation
import UIKit
import CoreData

struct SearchBookData: Codable {
    var title: String
    var authors: [String]
    var thumbnail: String
}

struct SearchResponse: Codable {
    var documents: [BookModel]
}

class SearchViewController: UIViewController, UITextFieldDelegate {
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let recentBooksLabel = UILabel()
    var tableView: UITableView!
    
    var searchResults: [BookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureConstraints()
        searchButton.addTarget(self, action: #selector(searchBooks), for: .touchUpInside)
        searchTextField.delegate = self
        setupUI()
    }
    
    private func setupUI() {
            searchTextField.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
            searchTextField.borderStyle = .roundedRect
            view.addSubview(searchTextField)

            searchButton.frame = CGRect(x: 330, y: 100, width: 40, height: 40)
            searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            view.addSubview(searchButton)
        }
    
    @objc func searchBooks() {
            guard let keyword = searchTextField.text, !keyword.isEmpty else { return }
            searchBooks(keyword: keyword)
        }

        private func searchBooks(keyword: String) {
            let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "https://dapi.kakao.com/v3/search/book?query=\(encodedKeyword)"
            guard let url = URL(string: urlString) else { return }

            var request = URLRequest(url: url)
            request.addValue("KakaoAK {69470f49582e1c713f730c39c4ef3736}", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.searchResults = responseData.documents
                        self?.tableView.reloadData() // Update your tableView
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }.resume()
        }
    }

    
    private func configureUI() {
        configureSearchTextField()
        configureSearchButton()
        configureRecentBooksLabel()
    }
    
    private func configureSearchTextField() {
        searchTextField.placeholder = "어떤 책이 필요하세요?"
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(searchTextField)
    }
    
    private func configureSearchButton() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .blue
        view.addSubview(searchButton)
    }
    
    private func configureRecentBooksLabel() {
        recentBooksLabel.text = "최근 본 책"
        recentBooksLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(recentBooksLabel)
    }
    
    private func configureConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        recentBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            recentBooksLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            recentBooksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentBooksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    func searchBooks(keyword: String) {
            let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "https://dapi.kakao.com/v3/search/book?query=\(encodedKeyword)"
            guard let url = URL(string: urlString) else { return }

            var request = URLRequest(url: url)
            request.addValue("KakaoAK 69470f49582e1c713f730c39c4ef3736", forHTTPHeaderField: "Authorization") // Replace xxxxx with your REST API Key

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(SearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.books = responseData.documents
                        // Update your UI here
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }.resume()
        }
    
//
//    @objc func searchBooks() {
//        guard let searchText = searchTextField.text, !searchText.isEmpty else { return }
//        showLoadingIndicator()
//        fetchBooks(searchText: searchText) { [weak self] (books, error) in
//            DispatchQueue.main.async {
//                self?.hideLoadingIndicator()
//                if let books = books {
//                    self?.searchResults = books
//                    self?.tableView.reloadData()
//                } else if let error = error {
//                    self?.showErrorAlert(message: "Failed to fetch books: \(error.localizedDescription)")
//                }
//            }
//        }
//    }

    func fetchBooks(searchText: String, completion: @escaping ([BookModel]?, Error?) -> Void) {
        let urlString = "https://api.example.com/books?query=\(searchText)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("YourAPIKey", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([BookModel].self, from: data)
                completion(books, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        for subview in view.subviews {
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
        present(alertController, animated: true, completion: nil)
    }
}
