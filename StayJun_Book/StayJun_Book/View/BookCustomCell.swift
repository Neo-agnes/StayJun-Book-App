//
//  BookCustomCell.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/7/24.
//

import Foundation
import UIKit

class BookCustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 원형 버튼 생성 및 스타일 설정
        let button = UIButton(type: .custom)
        let buttonSize: CGFloat = min(frame.width, frame.height) * 1.5 // 버튼 크기를 셀 크기의 80%로 설정
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        button.center = CGPoint(x: frame.width / 2, y: frame.height / 2) // 버튼을 셀의 중앙에 위치시킴
        button.layer.cornerRadius = buttonSize / 2 // 원형 버튼으로 만들기 위해 반지름 설정
        button.backgroundColor = .blue // 버튼의 배경색 설정
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
