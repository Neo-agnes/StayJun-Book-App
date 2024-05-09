//
//  SomeViewController.swift
//  StayJun_Book
//
//  Created by Developer_P on 5/9/24.
//

import Foundation
import UIKit
import CoreData

class SomeViewController: UIViewController, UITableViewDataSource {
    var books: [BookModel] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        loadBooksFromJSON { [weak self] loadedBooks in
            guard let books = loadedBooks else { return }
            self?.books = books
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
}
