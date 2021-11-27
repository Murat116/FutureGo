//
//  ElementTableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

class ElementTableView: UITableView {
    init(){
        super.init(frame: .zero)
        self.delegate = self
        self.dataSource = self
    }
}

extension
