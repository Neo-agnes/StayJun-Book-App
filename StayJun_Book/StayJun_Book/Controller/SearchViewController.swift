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
    
    let resultsLabel = UILabel().then {
        $0.text = "검색 결과"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.isHidden = true // Initially hide this label
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
        view.addSubview(resultsLabel) // Adding the results label to the view
    }
    
    private func setupConstraints() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        recentBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
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
            resultsLabel.topAnchor.constraint(equalTo: recentBooksLabel.bottomAnchor, constant: 20),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: resultsLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
           tableView = UITableView()
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HeaderCell")
           tableView.register(BookCustomCell.self, forCellReuseIdentifier: "BookCustomCell")
           tableView.dataSource = self
           tableView.delegate = self
           view.addSubview(tableView)
       }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1  // 검색 결과만 표시하기 때문에 섹션은 하나만 필요
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count  // 검색 결과의 수 만큼 행이 필요
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 모든 셀을 BookCustomCell로 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCustomCell", for: indexPath) as! BookCustomCell
        let book = searchResults[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = searchResults[indexPath.row]
        let bookDetailView = SearchBookView()
        bookDetailView.book = book  // 선택된 도서 데이터 전달
        bookDetailView.modalPresentationStyle = .automatic  // 모달 전체 화면 설정
        present(bookDetailView, animated: true, completion: nil)
    }
    
    @objc func searchBooks() {
            view.endEditing(true)
            guard let keyword = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
                return  // Optionally, show an alert or a message to the user
            }
            resultsLabel.isHidden = false // Show results label when search is initiated
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
extension SearchViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160  // 예를 들어, 각 셀의 높이를 160포인트로 설정
    }
}
