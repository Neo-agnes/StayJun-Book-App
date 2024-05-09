// SearchViewController.swift

import Foundation
import UIKit
import CoreData
import Then

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let searchTextField = UITextField().then {
        $0.placeholder = "어떤 책이 필요하세요?"
        $0.borderStyle = .roundedRect
        $0.layer.borderColor = UIColor.black.cgColor
    }

    let searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .blue
    }

    let recentBooksLabel = UILabel().then {
        $0.text = "최근 본 책"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }

    var tableView: UITableView!
    var searchResults: [BookModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupViews()
        setupConstraints()
        searchButton.addTarget(self, action: #selector(searchBooks), for: .touchUpInside)
    }

    private func setupViews() {
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupTableView() {
        tableView = UITableView()
        // HeaderCell 식별자로 기본 UITableViewCell을 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        // BookCustomCell 식별자로 BookCustomCell 클래스를 등록
        tableView.register(BookCustomCell.self, forCellReuseIdentifier: "BookCustomCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (searchResults.isEmpty ? 0 : 1)  // 항상 헤더를 위한 하나의 섹션, 결과가 있으면 추가 섹션
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // 헤더를 위한 한 줄만
            return 1
        } else {
            // 검색 결과에 해당하는 줄 수
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 첫 번째 섹션의 셀 구성
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            cell.textLabel?.text = "검색 결과"
            return cell
        } else {
            // 두 번째 섹션의 셀 구성
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCustomCell", for: indexPath) as! BookCustomCell
            let book = searchResults[indexPath.row]
            cell.configure(with: book)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {  // 헤더가 아닌 경우 확인
            let book = searchResults[indexPath.row]
            let bookDetailView = SearchBookView()
            bookDetailView.book = book
            present(bookDetailView, animated: true, completion: nil)
        }
    }
    
    @objc func searchBooks() {
        view.endEditing(true)
        guard let keyword = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
            return  // Optionally, show an alert or a message to the user
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
}
