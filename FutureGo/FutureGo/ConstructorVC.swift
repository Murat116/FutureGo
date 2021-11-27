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
    
    override func loadView() {
        self.view = backView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackView()
        setUpAppMap()
        setUpConfigComponentView()
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

