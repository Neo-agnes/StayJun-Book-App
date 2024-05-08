//
//  SearchBookView.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

import Foundation
import UIKit

class SearchBookView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    // Delegate 선언
    weak var delegate: SearchBookViewDelegate?

    // 콜렉션 뷰 선언
    private var collectionView: UICollectionView!
    
    // 데이터 소스
    var books: [Book] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .lightGray
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150) // 각 아이템의 크기 설정
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as? BookCollectionViewCell else {
            fatalError("Unable to dequeue BookCell")
        }
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }
    
    // 책 선택 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 책에 대한 처리를 구현합니다.
    }
    
    func showErrorAlert(message: String) {
        delegate?.presentAlert(from: self, withMessage: message)
    }
}
