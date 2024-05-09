//
//  Delegates.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/9/24.
//

import Foundation
import UIKit
import CoreData

protocol SearchBookViewDelegate: AnyObject {
    func presentAlert(from view: SearchBookView, withMessage message: String)
}
