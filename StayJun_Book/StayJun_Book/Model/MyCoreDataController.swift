////
////  SearchBookModel.swift
////  StayJun_Book
////
////  Created by Developer_P on 5/7/24.
////
//
//import Foundation
//import CoreData
//import UIKit
//
//class MyCoreDataController {
//    // 새로운 Book 객체를 생성하고 저장하는 메서드
//    func addNewBook(title: String, coverImage: String, publicationDate: Date) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//
//        // 코어 데이터 스택 설정
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        // Book 엔티티에 새로운 객체 생성
//        guard let bookEntity = NSEntityDescription.entity(forEntityName: "Books", in: managedContext) else {
//            return
//        }
//
//        let book = NSManagedObject(entity: bookEntity, insertInto: managedContext)
//
//        // 속성 설정
//        book.setValue(title, forKeyPath: "title")
//        book.setValue(coverImage, forKeyPath: "coverImage")
//        book.setValue(publicationDate, forKeyPath: "publicationDate")
//
//        // 변경 사항 저장
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//    
//    // 책을 검색하여 결과를 반환하는 메서드
//    func searchBooks(with keyword: String) -> [Book] {
//        var searchResults: [Book] = []
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return searchResults
//        }
//        
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
//        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", keyword)
//        
//        do {
//            let fetchedResults = try managedContext.fetch(fetchRequest)
//            for case let result as NSManagedObject in fetchedResults {
//                if let title = result.value(forKey: "title") as? String,
//                   let coverImage = result.value(forKey: "coverImage") as? String,
//                   let publicationDate = result.value(forKey: "publicationDate") as? Date {
//                    let book = Book()
//                    searchResults.append(book)
//                }
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//        
//        return searchResults
//    }
//}
