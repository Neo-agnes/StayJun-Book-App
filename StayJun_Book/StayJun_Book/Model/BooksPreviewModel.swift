//
//  BooksPreview.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/8/24.
//

import Foundation

// 책 정보를 나타내는 구조체 정의
struct BookModel: Codable {
    var title: String
    var authors: String
    var isbn: String
    var publishYear: Int
    var price: Double
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title, author, isbn, price
        case publishYear = "publish_year"
        case imageURL = "image_url"
    }
}

// 전체 데이터를 나타내는 구조체 정의
struct BookData: Codable {
    var books: [BookModel]
}

// 데이터를 로드하고 파싱하는 함수
func loadBooksFromJSON(completion: @escaping ([BookModel]?) -> Void) {
    guard let url = Bundle.main.url(forResource: "books", withExtension: "json") else {
        print("JSON file not found")
        completion(nil)
        return
    }
    
    DispatchQueue.global(qos: .userInitiated).async {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let bookData = try decoder.decode(BookData.self, from: data)
            DispatchQueue.main.async {
                completion(bookData.books)
            }
        } catch {
            print("Error decoding JSON: \(error)")
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
