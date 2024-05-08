//
//  SavedBooksViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import Foundation
import UIKit
import CoreData

class SavedBooksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 테이블 뷰
    let tableView: UITableView = {
        let tableView = UITableView()
        // 셀 등록
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // CoreData에서 가져온 책 객체의 제목을 저장하는 배열
    var savedBookTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰에 테이블 뷰 추가
        view.addSubview(tableView)
        
        // 테이블 뷰의 데이터 소스 및 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰의 레이아웃 설정
        tableView.frame = view.bounds
        
        // CoreData에서 데이터를 가져와서 저장하는 코드
        fetchBooks()
    }
    
    // CoreData에서 데이터를 가져와서 저장하는 메서드
    func fetchBooks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        do {
            let books = try managedContext.fetch(fetchRequest)
            savedBookTitles.removeAll()  // 배열을 비우고 시작
            for book in books {
                if let title = book.value(forKey: "title") as? String {
                    savedBookTitles.append(title)
                }
            }
            tableView.reloadData()  // 데이터를 로드한 후 테이블 뷰 갱신
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedBookTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = savedBookTitles[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 특정 책을 선택했을 때 동작 정의 (추후 구현)
    }
}

extension SearchViewController {
    func saveBook(title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: managedContext)!
        let book = NSManagedObject(entity: entity, insertInto: managedContext)
        book.setValue(title, forKey: "title")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            showErrorAlert(message: "책을 저장하는 데 실패했습니다: \(error.localizedDescription)")
        }
    }
}
