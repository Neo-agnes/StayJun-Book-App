//
//  BooksPreview.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

import Foundation

// 책 정보를 나타내는 구조체 정의
struct Book: Codable {
    var title: String
    var author: String
    var isbn: String
    var publishYear: Int
    
    enum CodingKeys: String, CodingKey {
        case title, author, isbn
        case publishYear = "publish_year"
    }
}

// 전체 데이터를 나타내는 구조체 정의
struct BookData: Codable {
    var books: [Book]
}

func loadBooksFromJSON() {
    guard let url = Bundle.main.url(forResource: "books", withExtension: "json") else {
        print("JSON file not found")
        return
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let bookData = try decoder.decode(BookData.self, from: data)
        for book in bookData.books {
            print("\(book.title) by \(book.author)")
        }
    } catch {
        print("Error decoding JSON: \(error)")
    }
}
