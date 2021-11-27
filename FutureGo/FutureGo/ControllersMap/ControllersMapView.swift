//
//  ControllersMapView.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

protocol MapViewInput: AnyObject {
    func addElement(view: UIView)
}

protocol SelectElementOutput: AnyObject {
    func selectElement(_ element: ElementModel)
}

class ControllersMapView: UICollectionView {
    
    var controllers: [ControllerModel] = []
    public var width: CGFloat = 0
    
    weak var selectOutput: SelectElementOutput?
    
    init(selectOutput: SelectElementOutput?) {
        self.selectOutput = selectOutput
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: flow)
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
        
        cell.configure(with: controllers[indexPath.row], selectOutput: selectOutput)
        
        return cell
    }
    
    
}

extension ControllersMapView: UICollectionViewDelegate {
}

extension ControllersMapView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.width, height: UIScreen.main.bounds.size.width)
    }
}

extension ControllersMapView: ElementTableViewOutput {
    func addElement(_ element: ElementModel) {
        let index = Int(self.visibleCells.count / 2)
        guard let cell = self.visibleCells[index] as? ControllersMapCell else {
            return
        }
        cell.addElement(element)
    }
}
