//
//  BookAPIManager.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//
import Foundation

struct BookModel: Codable {
    var title: String
    var authors: [String]
    var thumbnail: String
    var price: Int
    var contents: String // 책의 소개 정보
}

struct SearchResponse: Codable {
    var documents: [BookModel]
}
