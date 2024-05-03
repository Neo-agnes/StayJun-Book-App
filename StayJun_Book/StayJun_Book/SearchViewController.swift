//
//  SearchViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {

    // 검색어 입력을 위한 텍스트 필드
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색어를 입력하세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // 검색 버튼
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // 뷰에 UI 요소들 추가
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        // UI 요소들의 레이아웃 설정
        setupLayout()
    }
    
    // UI 요소들의 레이아웃을 설정하는 메서드
    private func setupLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // 검색어 입력 필드
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchTextField.widthAnchor.constraint(equalToConstant: 200),
            
            // 검색 버튼
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
