//
//  ElementTableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

protocol ElementTableViewOutput: AnyObject {
    func addElement(_ element: ElementsType)
}

class ElementTableView: UITableView {
    
    public weak var output: ElementTableViewOutput?
    
    init(){
        super.init(frame: .zero, style: .grouped)
        self.delegate = self
        self.dataSource = self
        self.register(UIElementCell.self, forCellReuseIdentifier: "UIElementCell")
        self.rowHeight = 60
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ElementTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ElementsType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UIElementCell") as? UIElementCell else { return UITableViewCell() }
        cell.configure(title: ElementsType.allCases[indexPath.row].title)
        return cell
    }
}

extension ElementTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = ElementsType.allCases[indexPath.row]
        self.output?.addElement(element)
        self.isHidden = true
    }
}


