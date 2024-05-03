//
//  SavedBooksViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import Foundation
import UIKit

class SavedBooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // 테이블 뷰
    let tableView: UITableView = {
        let tableView = UITableView()
        // 셀 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // 사용자가 담은 책 리스트 (임시 데이터)
    let savedBooks = ["Book 1", "Book 2", "Book 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰에 테이블 뷰 추가
        view.addSubview(tableView)
        
        // 테이블 뷰의 데이터 소스 및 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰의 레이아웃 설정
        tableView.frame = view.bounds
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = savedBooks[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 특정 책을 선택했을 때 동작 정의 (추후 구현)
    }
}
