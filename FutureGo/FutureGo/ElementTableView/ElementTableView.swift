//
//  ElementTableView.swift
//  FutureGo
//
//  Created by Мурат Камалов on 11/27/21.
//

import UIKit

protocol ElementTableViewOutput: AnyObject {
    func addElement(_ element: ElementModel)
}

class ElementTableView: UITableView {
    
    public weak var output: ElementTableViewOutput?
    
    private let elements = ElementsType.allCases.map { ElementModel(type: $0, frame: .zero) }
    
    init(){
        super.init(frame: .zero, style: .grouped)
        self.delegate = self
        self.dataSource = self
        self.register(UIElementCell.self, forCellReuseIdentifier: "UIElementCell")
        backgroundColor = .white
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ElementTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UIElementCell") as? UIElementCell else { return UITableViewCell() }
        cell.configure(with: ElementsType.allCases[indexPath.row])
        return cell
    }
}

extension ElementTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = elements[indexPath.row]
        let el = ElementModel(type: element.type, frame: element.frame)
        self.output?.addElement(el)
    }
}


