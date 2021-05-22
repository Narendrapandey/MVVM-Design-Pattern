//
//  ViewController.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet final private weak var mapView: MKMapView!
    
    // MARK: - Injection -
    final private let viewModel = MapListViewModel(service: WebService())
    
    // MARK: - Variable -
    final private let identifier = "VehicleListIdentifire"
    final private let placeHolderImage = "placeHolder"
    final private var sheetCoordinator: UBottomSheetCoordinator!
    final private var backView: PassThroughView?
    final private let listViewController = AppleMapsSheetViewController()
    final private var listOfVehicle =  [VehicleList]()
    
    // MARK: - View Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptNetworkCall()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard sheetCoordinator == nil else {return}
        sheetCoordinator = UBottomSheetCoordinator(parent: self,
                                                   delegate: self)
        
        listViewController.sheetCoordinator = sheetCoordinator
        sheetCoordinator.addSheet(listViewController, to: self, didContainerCreate: { container in
            let f = self.view.frame
            let rect = CGRect(x: f.minX, y: f.minY, width: f.width, height: f.height)
            container.roundCorners(corners: [.topLeft, .topRight], radius: 10, rect: rect)
        })
        sheetCoordinator.setCornerRadius(10)
    }
    
    private func addBackDimmingBackView(below container: UIView){
        backView = PassThroughView()
        view.insertSubview(backView!, belowSubview: container)
        backView!.translatesAutoresizingMaskIntoConstraints = false
        backView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backView!.bottomAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        backView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - UI Setup -
extension MapViewController {
    
    final private func attemptNetworkCall() {
        viewModel.getVehicleList()
        
        viewModel.updateLoadingStatus = { [self] in
            let _ = viewModel.isLoading ? activityIndicatorStart() : activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = { [self] in
            if let error = viewModel.error {
                DispatchQueue.main.async {
                    showError(error)
                }
            }
        }
        
        viewModel.didFinishFetch = { [self] in
            plog(viewModel.listOfVehicle)
            listOfVehicle = viewModel.listOfVehicle ?? []
            listViewController.listOfVehicle = listOfVehicle
            
            DispatchQueue.main.async {
                setAnnotation()
            }
        }
    }
    
    private func activityIndicatorStart() {
        
    }
    
    private func activityIndicatorStop() {
        
    }
    
    final private func showError(_ error: String) {
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    final private func setAnnotation() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotations = listOfVehicle.reduce(into: [VehicleAnnotation]()) { (result, vehicleType) in
            
            if let location = vehicleType.location,
               let vehicleDetail = vehicleType.vehicleDetails {
                
                let annotation = VehicleAnnotation(location.latitude,
                                                   location.longitude,
                                                   title: vehicleDetail.name,
                                                   subtitle: vehicleDetail.make,
                                                   carImage: vehicleType.carImageUrl,
                                                   vehicleId: vehicleType.id)
                
                result.append(annotation)
            }
            
        }
        
        mapView.addAnnotations(annotations)
        
        var zoomRect: MKMapRect = MKMapRect.null
        for annotation in mapView.annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x,
                                      y: annotationPoint.y,
                                      width: 0.1,
                                      height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }
        mapView.setVisibleMapRect(zoomRect,
                                  edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                                  animated: true)
    }
}

// MARK: - MKMap View Delegate -
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? VehicleAnnotation else { return nil }
        
        if let dequedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            annotationView = dequedView
        } else{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView.image = ImageLoader.shared.cacheImage(from: URL(string: annotation.carImage ?? ""))
        
        annotationView.markerTintColor = .clear
        annotationView.glyphTintColor = .clear
        annotationView.clusteringIdentifier = identifier
        return annotationView
    }
}

// MARK: - UBottom Sheet Coordinator Delegate -
extension MapViewController: UBottomSheetCoordinatorDelegate {
    
    func bottomSheet(_ container: UIView?, didPresent state: SheetTranslationState) {
        self.sheetCoordinator.addDropShadowIfNotExist()
        self.handleState(state)
    }
    
    func bottomSheet(_ container: UIView?, didChange state: SheetTranslationState) {
        handleState(state)
    }
    
    func bottomSheet(_ container: UIView?, finishTranslateWith extraAnimation: @escaping ((CGFloat) -> Void) -> Void) {
        extraAnimation({ [self] percent in
            backView?.backgroundColor = UIColor.black.withAlphaComponent(percent/100 * 0.8)
        })
    }
    
    func handleState(_ state: SheetTranslationState){
        switch state {
        case .progressing(_, let percent):
            backView?.backgroundColor = UIColor.black.withAlphaComponent(percent/100 * 0.8)
        case .finished(_, let percent):
            backView?.backgroundColor = UIColor.black.withAlphaComponent(percent/100 * 0.8)
        default:
            break
        }
    }
}
