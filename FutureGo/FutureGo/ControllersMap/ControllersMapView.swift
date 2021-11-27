//
//  ControllersMapView.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

struct ControllerModel {
    let id: Int
    let name: String
    
    static let testItems = [
        ControllerModel(id: 1, name: "one"),
        ControllerModel(id: 2, name: "second"),
        ControllerModel(id: 3, name: "third"),
        ControllerModel(id: 4, name: "fourth")
    ]
}

class ControllersMapView: UICollectionView {
    
    var controllers: [ControllerModel] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flow = UICollectionViewFlowLayout()
        let mainSize = UIScreen.main.bounds.size
        flow.itemSize = CGSize(width: mainSize.height - 400, height: mainSize.width)
        flow.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: flow)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        backgroundColor = .gray
        
        delegate = self
        dataSource = self
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        
        register(ControllersMapCell.self, forCellWithReuseIdentifier: "ControllersMapCell")
    }
    
    func configure(with controllers: [ControllerModel]) {
        self.controllers = controllers
        reloadData()
    }
}

extension ControllersMapView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ControllersMapCell", for: indexPath) as! ControllersMapCell
        
        cell.configure(with: controllers[indexPath.row])
        
        return cell
    }
    
    
}

extension ControllersMapView: UICollectionViewDelegate {
}
