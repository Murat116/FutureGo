//
//  Map.swift
//  FutureGo
//
//  Created by Roman Shurkin on 28.11.2021.
//

import Foundation
import MapKit

class MapView : DragableView {
    let map = MKMapView(frame: .zero)
    
    override init(frame: CGRect, model: ElementModel, parentView: ParentView, id: String, selectOutput: SelectElementOutput?) {
        super.init(frame: frame, model: model, parentView: parentView, id: id, selectOutput: selectOutput)
        self.addSubview(self.map)
        self.map.pinToSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
