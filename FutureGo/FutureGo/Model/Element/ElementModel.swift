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
    
//    var model = [BackendModel]()
    
    func changeFrame(frame: CGRect) {
        self.frame = frame
    }
    
    var parametrs = [ConfigParametrModel]()
    
    func getUIProection(parentView: ParentView, output: SelectElementOutput?, id: String) -> UIView {
        switch type {
        case .window:
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
            let view = DragableView(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.systemPink),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            return view
            
        case .tableView:
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
            let view = DragableTableView(frame: frame, parentView: parentView, id: id, selectOutput: output)
            return view
            
        case .button:
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
            let view =  DragableButton(frame: frame,
                                       model: self,
                                       parentView: parentView,
                                       selectOutput: output, id: id)
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.gray),
                    .textColor(.black),
                    .title("Some Text"),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            return view
            
        case .textField:
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
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
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
            let view = DragableImageView(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .title(nil),
                    .backgroundImage(UIImage(named: "cozy_house")),
                    .radius(8),
                    .action(nil)
                ]
            }
            view.configure(with: parametrs)
            
            return view
            
        case .label:
            let frame = self.frame == .zero ? CGRect(x: 87, y: 356, width: 200, height: 100) : self.frame
            let view = DragableLabel(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            view.label.textAlignment = .center
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(UIColor(hex: "#EAF2FC")),
                    .title("Cool Label!"),
                    .textColor(UIColor(hex: "#AAC805")),
                    .radius(8),
                    .action(nil)
                ]
            }
            
            view.configure(with: parametrs)
            
            return view
        case .swipableView:
            let frame = self.frame == .zero ? CGRect(x: 62, y: 83, width: 322, height: 563) : self.frame
            let view = DragableSwipe(frame: frame, model: self, parentView: parentView, id: id, selectOutput: output)
            
            if parametrs.isEmpty {
                self.parametrs = [
                    .backgroundColor(.clear),
                    .radius(8),
                    .backgroundImage(UIImage(named: "swipeBack"))
                ]
            }
            
            view.configure(with: parametrs)
            return view
        }
    }
    
    func getRealElement(parentView: UIView) -> UIView {
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
            view.backgroundColor = .darkGray
//            view.swipeViews = SwipeableCardViewCard()
            
            for model in MyModel.model {
                let swipableView = SwipeableCardViewCard()
                swipableView.backgroundColor = .darkGray
                for element in self.subview {
                    
                    let subView = element.getRealElement(parentView: view)
                    swipableView.addSubview(subView)
                    let tap = subView.frame.origin
                    let convertedTap = parentView.convert(tap, to: view)
                    subView.frame.origin = convertedTap
                    
                    switch element.type {
                    case .label:
                        let lbl = subView as! UILabel
                        lbl.textAlignment = .center
                        switch lbl.text {
                        case "Title":
                            lbl.text = model.title
                        case "Price":
                            lbl.text = model.price
                        case "Percent":
                            lbl.text = model.upString
                        default:
                            break
                        }
                    case .image:
                        (subView as! UIImageView).image = model.graphic
                    default:
                        break
                    }
                }
                view.swipeViews.append(swipableView)
            }
            
            view.reloadData()
            return view
        }
    }
}


//class MyImage: TappedImageView {
//
//    let imagePredictor = ImagePredictor()
//
//    override var image: UIImage? {
//        didSet {
//            self.classifyImage(self.image!)
//        }
//    }
//
//    private func classifyImage(_ image: UIImage) {
//        do {
//            try self.imagePredictor.makePredictions(for: image,
//                                                    completionHandler: imagePredictionHandler)
//        } catch {
//            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
//        }
//    }
//
//    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
//        guard let predictions = predictions else {
//            updatePredictionLabel("No predictions. (Check console log.)")
//            return
//        }
//
//        let formattedPredictions = formatPredictions(predictions)
//
//        let predictionString = formattedPredictions.joined(separator: "\n")
//        updatePredictionLabel(predictionString)
//    }
//
//    let predictionsToShow = 2
//
//    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
//        // Vision sorts the classifications in descending confidence order.
//        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
//            var name = prediction.classification
//
//            // For classifications with more than one name, keep the one before the first comma.
//            if let firstComma = name.firstIndex(of: ",") {
//                name = String(name.prefix(upTo: firstComma))
//            }
//
//            return "\(name) - \(prediction.confidencePercentage)%"
//        }
//
//        return topPredictions
//    }
//
//    var firstRun = true
//
//    func updatePredictionLabel(_ message: String) {
//        DispatchQueue.main.async {
//            print(message)
//            self.label.text = message
//            self.label.backgroundColor = .white
////            self.predictionLabel.text = message
//        }
//
//        if firstRun {
//            DispatchQueue.main.async {
//                self.firstRun = false
////                self.predictionLabel.superview?.isHidden = false
////                self.startupPrompts.isHidden = true
//            }
//        }
//    }
//}
//
//
//import Vision
//import UIKit
//
///// A convenience class that makes image classification predictions.
/////
///// The Image Predictor creates and reuses an instance of a Core ML image classifier inside a ``VNCoreMLRequest``.
///// Each time it makes a prediction, the class:
///// - Creates a `VNImageRequestHandler` with an image
///// - Starts an image classification request for that image
///// - Converts the prediction results in a completion handler
///// - Updates the delegate's `predictions` property
///// - Tag: ImagePredictor
//class ImagePredictor {
//    /// - Tag: name
//    static func createImageClassifier() -> VNCoreMLModel {
//        // Use a default model configuration.
//        let defaultConfig = MLModelConfiguration()
//
//        // Create an instance of the image classifier's wrapper class.
//        let imageClassifierWrapper = try? MobileNet(configuration: defaultConfig)
//
//        guard let imageClassifier = imageClassifierWrapper else {
//            fatalError("App failed to create an image classifier model instance.")
//        }
//
//        // Get the underlying model instance.
//        let imageClassifierModel = imageClassifier.model
//
//        // Create a Vision instance using the image classifier's model instance.
//        guard let imageClassifierVisionModel = try? VNCoreMLModel(for: imageClassifierModel) else {
//            fatalError("App failed to create a `VNCoreMLModel` instance.")
//        }
//
//        return imageClassifierVisionModel
//    }
//
//    /// A common image classifier instance that all Image Predictor instances use to generate predictions.
//    ///
//    /// Share one ``VNCoreMLModel`` instance --- for each Core ML model file --- across the app,
//    /// since each can be expensive in time and resources.
//    private static let imageClassifier = createImageClassifier()
//
//    /// Stores a classification name and confidence for an image classifier's prediction.
//    /// - Tag: Prediction
//    struct Prediction {
//        /// The name of the object or scene the image classifier recognizes in an image.
//        let classification: String
//
//        /// The image classifier's confidence as a percentage string.
//        ///
//        /// The prediction string doesn't include the % symbol in the string.
//        let confidencePercentage: String
//    }
//
//    /// The function signature the caller must provide as a completion handler.
//    typealias ImagePredictionHandler = (_ predictions: [Prediction]?) -> Void
//
//    /// A dictionary of prediction handler functions, each keyed by its Vision request.
//    private var predictionHandlers = [VNRequest: ImagePredictionHandler]()
//
//    /// Generates a new request instance that uses the Image Predictor's image classifier model.
//    private func createImageClassificationRequest() -> VNImageBasedRequest {
//        // Create an image classification request with an image classifier model.
//
//        let imageClassificationRequest = VNCoreMLRequest(model: ImagePredictor.imageClassifier,
//                                                         completionHandler: visionRequestHandler)
//
//        imageClassificationRequest.imageCropAndScaleOption = .centerCrop
//        return imageClassificationRequest
//    }
//
//    /// Generates an image classification prediction for a photo.
//    /// - Parameter photo: An image, typically of an object or a scene.
//    /// - Tag: makePredictions
//    func makePredictions(for photo: UIImage, completionHandler: @escaping ImagePredictionHandler) throws {
//        let orientation = CGImagePropertyOrientation.down
//
//        guard let photoImage = photo.cgImage else {
//            fatalError("Photo doesn't have underlying CGImage.")
//        }
//
//        let imageClassificationRequest = createImageClassificationRequest()
//        predictionHandlers[imageClassificationRequest] = completionHandler
//
//        let handler = VNImageRequestHandler(cgImage: photoImage, orientation: orientation)
//        let requests: [VNRequest] = [imageClassificationRequest]
//
//        // Start the image classification request.
//        try handler.perform(requests)
//    }
//
//    /// The completion handler method that Vision calls when it completes a request.
//    /// - Parameters:
//    ///   - request: A Vision request.
//    ///   - error: An error if the request produced an error; otherwise `nil`.
//    ///
//    ///   The method checks for errors and validates the request's results.
//    /// - Tag: visionRequestHandler
//    private func visionRequestHandler(_ request: VNRequest, error: Error?) {
//        // Remove the caller's handler from the dictionary and keep a reference to it.
//        guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
//            fatalError("Every request must have a prediction handler.")
//        }
//
//        // Start with a `nil` value in case there's a problem.
//        var predictions: [Prediction]? = nil
//
//        // Call the client's completion handler after the method returns.
//        defer {
//            // Send the predictions back to the client.
//            predictionHandler(predictions)
//        }
//
//        // Check for an error first.
//        if let error = error {
//            print("Vision image classification error...\n\n\(error.localizedDescription)")
//            return
//        }
//
//        // Check that the results aren't `nil`.
//        if request.results == nil {
//            print("Vision request had no results.")
//            return
//        }
//
//        // Cast the request's results as an `VNClassificationObservation` array.
//        guard let observations = request.results as? [VNClassificationObservation] else {
//            // Image classifiers, like MobileNet, only produce classification observations.
//            // However, other Core ML model types can produce other observations.
//            // For example, a style transfer model produces `VNPixelBufferObservation` instances.
//            print("VNRequest produced the wrong result type: \(type(of: request.results)).")
//            return
//        }
//
//        // Create a prediction array from the observations.
//        predictions = observations.map { observation in
//            // Convert each observation into an `ImagePredictor.Prediction` instance.
//            Prediction(classification: observation.identifier,
//                       confidencePercentage: observation.confidencePercentageString)
//        }
//    }
//}
//
//import CoreML
//
//
//
//
//
//
//
//extension VNClassificationObservation {
//    /// Generates a string of the observation's confidence as a percentage.
//    var confidencePercentageString: String {
//        let percentage = confidence * 100
//
//        switch percentage {
//            case 100.0...:
//                return "100%"
//            case 10.0..<100.0:
//                return String(format: "%2.1f", percentage)
//            case 1.0..<10.0:
//                return String(format: "%2.1f", percentage)
//            case ..<1.0:
//                return String(format: "%1.2f", percentage)
//            default:
//                return String(format: "%2.1f", percentage)
//        }
//    }
//}
