//
//  ConfigComponentView.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConfigComponentView: UITableView {
    
    var parametrs: [ConfigParametrModel] = []
    
    weak var editingParametrOutput: EditingParametrOutput?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        dataSource = self
        separatorStyle = .none
        
        register(ConfigComponentCell.self, forCellReuseIdentifier: "ConfigComponentCell")
    }
    
    func configure(with parametrs: [ConfigParametrModel], editingParametrOutput: EditingParametrOutput?) {
        self.editingParametrOutput = editingParametrOutput
        self.parametrs = parametrs
        reloadData()
    }
}
extension ConfigComponentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parametrs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigComponentCell", for: indexPath) as! ConfigComponentCell
        
        cell.configure(with: parametrs[indexPath.row], editingOutput: editingParametrOutput)
        return cell
    }
}
