//
//  ConstructorVC.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

class ConstructorVC: UIViewController {
    
    private let backView = UIView()
    
    private let appMap = UIView()
    
    private let configComponentView = UIView()
    
    private lazy var elementView: ElementTableView = {
        let view = ElementTableView(output: self)
        return view
    }()
    
    override func loadView() {
        self.view = backView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackView()
        setUpAppMap()
        setUpConfigComponentView()
        self.view.addSubview(self.elementView)
        self.elementView.pinToSuperView(sides: [.topR,.rightR,.bottomR])
        self.elementView.setDemission(.width(100))
    }
    
    private func setUpBackView() {
        backView.backgroundColor = .gray
    }
    
    private func setUpAppMap() {
        appMap.backgroundColor = .white
    }
    
    private func setUpConfigComponentView() {
        configComponentView.backgroundColor = .white
    }
}

extension ConstructorVC: ElementTableViewOutput {
    func addElement(_ element: ElementsType) {
        let view = element.getUIProection(parentView: self.view)
        self.view.addSubview(view)
    }
}
