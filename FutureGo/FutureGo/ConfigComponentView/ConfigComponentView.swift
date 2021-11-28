//
//  ConfigComponentView.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConfigComponentView: UITableView {
    
    var idElement: String?
    
    var parametrs: [ConfigParametrModel] = []
    
    weak var editingParametrOutput: EditingParametrOutput?
    weak var parentVC: UIViewController?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        dataSource = self
        delegate = self
        separatorStyle = .none
        
        register(ConfigComponentCell.self, forCellReuseIdentifier: "ConfigComponentCell")
        register(ConfigBackendParametrCell.self, forCellReuseIdentifier: "ConfigBackendParametrCell")
    }
    
    func configure(with parametrs: [ConfigParametrModel], idElement: String?, editingParametrOutput: EditingParametrOutput?, parentVC: UIViewController?) {
        self.idElement = idElement
        self.editingParametrOutput = editingParametrOutput
        self.parametrs = parametrs
        self.parentVC = parentVC
        reloadData()
    }
}
extension ConfigComponentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parametrs.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= parametrs.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigBackendParametrCell", for: indexPath) as! ConfigBackendParametrCell
            
            cell.configure(index: indexPath.row, paramsCount: parametrs.count, parentVC: parentVC)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigComponentCell", for: indexPath) as! ConfigComponentCell
            
            cell.configure(with: parametrs[indexPath.row], idElement: idElement, editingOutput: editingParametrOutput, parentVC: parentVC)
            return cell
        }
    }
}
