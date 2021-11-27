//
//  ViewController.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = ElementTableView(output: self)
        self.view.addSubview(tableView)
        tableView.pinToSuperView()
        tableView.reloadData()
    }
}

extension ViewController: ElementTableViewOutput {
    func addElement(_ element: ElementsType) {
        self.view.addSubview(element.element)
    }
}

