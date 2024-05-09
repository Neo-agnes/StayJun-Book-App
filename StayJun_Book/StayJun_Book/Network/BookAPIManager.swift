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
    var price: String
}

struct SearchResponse: Codable {
    var documents: [BookModel]
}
