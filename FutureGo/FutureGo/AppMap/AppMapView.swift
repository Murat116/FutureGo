//
//  AppMapView.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class AppMapView: UITableView {
    
    var controllers: [ControllerModel] = []
    
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
        
        register(ControllerDesrCell.self, forCellReuseIdentifier: "ControllerDesrCell")
    }
    
    func configure(with controllers: [ControllerModel]) {
        self.controllers = controllers
        reloadData()
    }
}
extension AppMapView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ControllerDesrCell", for: indexPath) as! ControllerDesrCell
        
        cell.configure(with: controllers[indexPath.row])
        return cell
    }
}
