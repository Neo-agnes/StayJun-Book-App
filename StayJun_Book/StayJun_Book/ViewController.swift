//
//  ViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/3/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIView 생성
        let myView = UIView()
        myView.backgroundColor = .blue
        
        // UIView의 frame 설정 (x, y, width, height)
        myView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        // 현재 ViewController의 view에 myView 추가
        view.addSubview(myView)
        
        // UILabel 생성 및 설정
        let myLabel = UILabel()
        myLabel.text = "Hello, World!"
        myLabel.textColor = .white
        
        // UILabel의 크기를 텍스트에 맞게 조절
        myLabel.sizeToFit()
        
        // UILabel을 myView의 중앙에 위치시키기
        myLabel.center = CGPoint (x: myView.frame.size.width  / 2,
                                  y: myView.frame.size.height / 2)
        
        // myView에 myLabel 추가
        myView.addSubview(myLabel)
    }
}
