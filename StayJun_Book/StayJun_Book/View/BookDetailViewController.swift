//
//  BookDetailViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//
import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    
    // 책 상세 정보를 표시할 레이블 등 필요한 UI 요소 추가
    
    var book: Book? // 책 정보를 저장할 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 책 정보를 기반으로 UI 설정
        
        // 모달 방식으로 화면을 표시
        self.modalPresentationStyle = .fullScreen
    }
}
