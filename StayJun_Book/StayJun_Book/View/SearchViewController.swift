// SearchViewController.swift

import Foundation
import UIKit
import CoreData

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let recentBooksLabel = UILabel()
    var tableView: UITableView!
    
    var searchResults: [BookModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupTableView() // 테이블 뷰 설정을 확실히 호출
        setupConstraints()
        searchButton.addTarget(self, action: #selector(searchBooks), for: .touchUpInside)
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
    }

    private func setupConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        recentBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),

            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),

            recentBooksLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            recentBooksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentBooksLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: recentBooksLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "bookCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    @objc func searchBooks() {
        view.endEditing(true)  // 키보드를 닫아 현재 포커스를 해제
        guard let keyword = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
            // 여기에 사용자에게 입력이 비어있음을 알리는 UI 로직을 추가할 수 있습니다.
            return
        }
        kakaoSearchBooks(keyword: keyword)
    }

    private func kakaoSearchBooks(keyword: String) {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://dapi.kakao.com/v3/search/book?query=\(encodedKeyword)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.addValue("KakaoAK 69470f49582e1c713f730c39c4ef3736", forHTTPHeaderField: "Authorization")

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
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let book = searchResults[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = "저자: \(book.authors.joined(separator: ", "))"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = searchResults[indexPath.row]
        myshowBookDetails(book)
    }

    func myshowBookDetails(_ book: BookModel) {
        let detailVC = BookDetailViewController()
        detailVC.book = book
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
