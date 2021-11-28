//
//  ElementModel.swift
//  FutureGo
//
//  Created by Roman Shurkin on 27.11.2021.
//

import UIKit

struct FrameRect: Codable {
    let x: Float
    let y: Float
    let width: Float
    let height: Float
    
    static func fromCGRect(_ rect: CGRect) -> FrameRect {
        FrameRect(x: Float(rect.origin.x), y: Float(rect.origin.y), width: Float(rect.width), height: Float(rect.height))
    }
}

class ElementModel: Codable  {
    internal init(type: ElementsType, frame: CGRect) {
        self.type = type
        self.frame = frame
    }
    

    var id = UUID().uuidString
    
    let type: ElementsType
    
    var frame: CGRect
    
    var subview = [ElementModel]()
    
    func changeFrame(frame: CGRect) {
        self.frame = frame
    }
    
    var parametrs = [ConfigParametrModel]()
    
    func getUIProection(parentView: ParentView, output: SelectElementOutput?, id: String) -> UIView {
        switch type {
        case .window:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 400, height: 400) : self.frame
            let view = DragableView(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            return view
            
        case .tableView:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 400, height: 400) : self.frame
            let view = DragableTableView(frame: frame, parentView: parentView, id: id, selectOutput: output)
            return view
            
        case .button:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 450, height: 100) : self.frame
            let view =  DragableButton(frame: frame,
                                       model: self,
                                       parentView: parentView,
                                       selectOutput: output, id: id)
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .textColor(.black),
                    .title("Some Text ..."),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            return view
            
        case .textField:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 400, height: 400) : self.frame
            let view = DragableTextField(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .textColor(.black),
                    .title("Some Text ..."),
                    .radius(8)
                ]
            }
            view.configure(with: parametrs)
            return view
            
        case .image:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 400, height: 400) : self.frame
            let view = DragableImageView(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            view.backgroundColor = .gray
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .title(nil),
                    .backgroundImage(nil),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            
            return view
            
        case .label:
            let frame = self.frame == .zero ? CGRect(x: 200, y: 400, width: 400, height: 400) : self.frame
            let view = DragableLabel(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .title("Some Text ..."),
                    .textColor(.black),
                    .radius(8),
                    .action(nil)
                ]
            }
            
            view.configure(with: parametrs)
            
            return view
        case .swipableView:
            let frame = self.frame == .zero ? CGRect(x: 100, y: 100, width: 200, height: 200) : self.frame
            let view = DragableSwipe(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .radius(8)
                ]
            }
            
            view.configure(with: parametrs)
            return view
        }
    }
    
    func getAction() -> String? {
        return ""
    }
    
    func getRealElement() -> UIView {
        switch self.type {
        case .window:
            let view = TappedView(frame: self.frame)
            for parameter in self.parametrs {
                switch parameter {
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                case .action(let idForPush):
                    view.idContrForPush = idForPush
                default:
                    break
                }
            }
            return view
        case .tableView:
            let view = UITableView(frame: self.frame)
            view.backgroundColor = .brown
            return view
        case .button:
            let view = TappedBtn(frame: self.frame)
            for parameter in self.parametrs {
                switch parameter {
                case .title(let optional):
                    view.setTitle(optional, for: .normal)
                case .textColor(let optional):
                    view.setTitleColor(optional, for: .normal)
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                case .backgroundImage(let optional):
                    view.setImage(optional, for: .normal)
                case .action(let idForPush):
                    view.idContrForPush = idForPush
                default:
                    break
                }
            }
            
            return view
        case .textField:
            let view = UITextField(frame: self.frame)
            for parameter in self.parametrs {
                switch parameter {
                case .title(let optional):
                    view.text = optional
                case .textColor(let optional):
                    view.textColor = optional
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                default:
                    break
                }
            }
            return view
        case .image:
            let view = TappedImageView(frame: self.frame)
            view.clipsToBounds = true
            view.backgroundColor = .green
            for parameter in self.parametrs {
                switch parameter {
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                case .backgroundImage(let image):
                    view.image = image
                case .action(let idForPush):
                    view.idContrForPush = idForPush
                default:
                    break
                }
            }
            return view
        case .label:
            let view = TappedLabel(frame: self.frame)
            for parameter in self.parametrs {
                switch parameter {
                case .backgroundColor(let optional):
                    view.backgroundColor = optional
                case .radius(let optional):
                    view.layer.cornerRadius = optional ?? 0
                case .textColor(let color):
                    view.textColor = color
                case .title(let text):
                    view.text = text
                case .action(let idForPush):
                    view.idContrForPush = idForPush
                default:
                    break
                }
            }
            return view
        case .swipableView:
            let view = SwipeableCardViewContainer()
            view.frame = self.frame
            view.backgroundColor = .yellow
            view.reloadData()
            return view
        }
    }
}
