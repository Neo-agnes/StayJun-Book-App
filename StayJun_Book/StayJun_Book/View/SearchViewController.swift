//
//  SearchViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import Foundation
import UIKit
import CoreData

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - UI 추가
    let searchTextField = UITextField()
    let searchButton = UIButton()
    let recentBooksLabel = UILabel()
    let BookCustomCellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let myCoreDataController = MyCoreDataController()
    let searchResultLabel = UILabel()
    let collectionLayout = UICollectionViewFlowLayout()
    var searchResultViews: [UIView] = []
    
    // CoreData에서 가져온 책 객체의 배열
    var searchResults: [Book] = []
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        BookCustomCellCollectionView.delegate = self
        BookCustomCellCollectionView.dataSource = self
        //myCoreDataController.addNewBook(title: "나의 작은 라임 오렌지 나무", coverImage: "이미지 경로", publicationDate: Date())
    }
    
    //MARK: - setupUI
    private func setupUI() {
        // 검색어 입력 필드
        searchTextField.placeholder = "어떤 책이 필요하세요?"
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.borderColor = UIColor.black.cgColor // 검은색 테두리 설정
        
        // 검색 버튼
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal) // 돋보기 모양 이미지 설정
        searchButton.tintColor = .blue // 버튼 색상 설정
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside) // 검색 버튼 액션 추가
        
        // "최근 본 책" 레이블
        recentBooksLabel.text = "최근 본 책"
        recentBooksLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // 컬렉션 뷰 초기화
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumInteritemSpacing = 0 // 수평 간격 설정
        collectionLayout.minimumLineSpacing = 0 // 수직 간격 설정
        BookCustomCellCollectionView.collectionViewLayout = collectionLayout
        BookCustomCellCollectionView.register(BookCustomCell.self, forCellWithReuseIdentifier: "BookCustomCell") // 커스텀 셀 등록
        BookCustomCellCollectionView.backgroundColor = .clear
        
        // "검색 결과" 레이블
        searchResultLabel.text = "검색 결과"
        searchResultLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        // 검색 결과를 담은 뷰들
        for _ in 0..<3 {
            let resultView = UIView()
            resultView.backgroundColor = .lightGray // 임시로 배경색 설정
            searchResultViews.append(resultView)
        }
        
        // UI 요소들을 뷰에 추가
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(recentBooksLabel)
        view.addSubview(BookCustomCellCollectionView) // BookCustomCellCollectionView 추가
        view.addSubview(searchResultLabel)
        searchResultViews.forEach { view.addSubview($0) }
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 셀의 개수를 반환합니다.
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 셀을 구성하여 반환합니다.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCustomCell", for: indexPath) as! BookCustomCell
        // 셀에 책 정보 표시
        let book = searchResults[indexPath.item]
        cell.titleLabel.text = book.title
        cell.coverImageView.image = UIImage(named: book.coverImage ?? "") // 책 이미지 설정
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout 프로토콜 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 100 // 셀의 폭
        let cellHeight: CGFloat = 100 // 셀의 높이
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20 // 셀 간의 수평 간격
    }
    
    //MARK: - 검색 버튼 액션
    @objc private func searchButtonTapped() {
        // 검색어가 비어있는지 확인
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            // 검색어가 비어있는 경우에 대한 처리 (예: 사용자에게 알림 표시)
            return
        }
        
        // CoreData에서 검색어에 해당하는 책을 찾아옴
        searchResults = myCoreDataController.searchBooks(with: searchText)
        
        // 컬렉션 뷰 업데이트
        BookCustomCellCollectionView.reloadData()
    }
    
    //MARK: - setupLayout
    private func setupLayout() {
        // 검색어 입력 필드
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10)
        ])
        
        // 검색 버튼
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
        ])
        
        // "최근 본 책" 레이블
        recentBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentBooksLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recentBooksLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20)
        ])
        
        // 원형 버튼을 담은 뷰
        BookCustomCellCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            BookCustomCellCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            BookCustomCellCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            BookCustomCellCollectionView.topAnchor.constraint(equalTo: recentBooksLabel.bottomAnchor, constant: 10),
            BookCustomCellCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // "검색 결과" 레이블
        searchResultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchResultLabel.topAnchor.constraint(equalTo: BookCustomCellCollectionView.bottomAnchor, constant: 20)
        ])
        
        // 검색 결과를 담은 뷰들
        for (index, resultView) in searchResultViews.enumerated() {
            resultView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                resultView.topAnchor.constraint(equalTo: searchResultLabel.bottomAnchor, constant: 10),
                resultView.widthAnchor.constraint(equalToConstant: 300),
                resultView.heightAnchor.constraint(equalToConstant: 100),
                resultView.leadingAnchor.constraint(equalTo: index == 0 ? view.leadingAnchor : searchResultViews[index - 1].trailingAnchor, constant: index == 0 ? 20 : 10),
                resultView.trailingAnchor.constraint(equalTo: index == searchResultViews.count - 1 ? view.trailingAnchor : searchResultViews[index + 1].leadingAnchor, constant: index == searchResultViews.count - 1 ? -20 : -10)
            ])
        }
    }
}
