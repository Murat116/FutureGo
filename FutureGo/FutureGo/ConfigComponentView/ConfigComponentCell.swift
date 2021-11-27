//
//  ConfigComponentCell.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

protocol EditingParametrOutput: AnyObject {
    func changeParametr(_ parametr: ConfigParametrModel, for idElement: String?)
}

class ConfigComponentCell: UITableViewCell {
    
    let configView = ConfigComponentElementView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        selectionStyle = .none
        
        contentView.addSubview(configView)
        
        configView.pinToSuperView(sides: [.leftR, .rightR, .topR])
        contentView.pin(side: .bottomR, to: .bottom(configView))
    }
    
    func configure(with model: ConfigParametrModel, idElement: String?, editingOutput: EditingParametrOutput?) {
        configView.configure(with: model, idElement: idElement, editingOutput: editingOutput)
    }
}

class ConfigComponentElementView: UIView {
    
    var idElement: String?
    var model: ConfigParametrModel?
     
    weak var editingOutput: EditingParametrOutput?
    
    let nameLabel = UILabel()
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        
        addSubview(nameLabel)
        nameLabel.pinToSuperView(sides: [.top(10), .left(10), .right(-10)])
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        addSubview(textField)
        textField.pinToSuperView(sides: [.left(10), .right(-10)])
        textField.pin(side: .top(5), to: .bottom(nameLabel))
        
        pin(side: .bottom(10), to: .bottom(textField))
    }
    
    func configure(with model: ConfigParametrModel, idElement: String?, editingOutput: EditingParametrOutput?) {
        self.model = model
        self.idElement = idElement
        self.editingOutput = editingOutput
        nameLabel.text = model.name
        textField.text = ""
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let model = model else { return }
        
        var newParametr: ConfigParametrModel? = nil
        
        switch model {
        case .title(_):
            newParametr = .title(textField.text)
        case .textColor(_):
            break
        case .backgroundColor(_):
            break
        case .radius(_):
            guard let val = Double(textField.text ?? "") else { break }
            newParametr = .radius(CGFloat(val))
        case .backgroundImage(_):
            break
        case .action(_):
            break
        }
        
        guard let param = newParametr else { return }
        self.editingOutput?.changeParametr(param, for: idElement)
    }
}
