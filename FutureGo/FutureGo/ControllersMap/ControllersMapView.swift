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

protocol MapViweOutput: AnyObject {
    func realoadData(with controllers: [ControllerModel])
    var selectedElement: ElementModel? { get set }
}

class ControllersMapView: UICollectionView {
    
    var controllers: [ControllerModel] = []
    public var width: CGFloat = 0 {
        didSet{
            self.contentInset = UIEdgeInsets(top: 0, left: self.width - 100 - 375/2, bottom: 0, right: 0)
        }
    }
    
    public weak var output: MapViweOutput?
    
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
        
        backgroundColor = UIColor(hex: "#DEDFDF")
        
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
        
        cell.configure(with: controllers[indexPath.row], output: self, selectOutput: selectOutput)
        
        return cell
    }
    
    
}

extension ControllersMapView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output?.selectedElement = nil
    }
}

extension ControllersMapView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 812)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (width - 375) / 2
    }
}

extension ControllersMapView: ElementTableViewOutput {
    func addElement(_ element: ElementModel) {
        if self.output?.selectedElement != nil {
            self.output?.selectedElement?.subview.append(element)
        }
        let index = Int(self.visibleCells.count / 2)
        guard let cell = self.visibleCells[index] as? ControllersMapCell else {
            return
        }
        cell.addElement(element, isSubView: self.output?.selectedElement != nil)
        guard self.output?.selectedElement == nil else {
//            self.reloadData()
            return
        }
        let indexOfController = self.controllers.firstIndex{ $0.id == cell.controllerModel?.id }
        guard let indexOfController = indexOfController else { return }
        self.controllers[indexOfController].elements.append(element)
        self.output?.realoadData(with: self.controllers)
    }
}

extension ControllersMapView: ControllersMapCellOutput {
    func changeModelOf(model: ControllerModel?) {
        let indexOfController = self.controllers.firstIndex{ $0.id == model!.id }
        guard let indexOfController = indexOfController else { return }
        self.controllers[indexOfController] = model!
//        self.output?.realoadData(with: self.controllers)
    }
    
    func removewFromSuperview(model: ControllerModel, element: ElementsType) {
        let indexOfController = self.controllers.firstIndex{ $0.id == model.id }
        guard let indexOfController = indexOfController else { return }
//        let index = self.controllers[indexOfController].elements.first(where: $0 == element)
//        self.controllers[indexOfController].elements.removeFir
//        self.output?.realoadData(with: self.controllers)
    }
}
