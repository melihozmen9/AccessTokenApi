//
//  MapVC.swift
//  AccessTokenApi
//
//  Created by Kullanici on 18.08.2023.
//Scroll To Item collectin view'da istediğim index'deki cell'e götürecek.

import UIKit
import MapKit
import TinyConstraints
class MapVC: UIViewController {
    
    let viewModal = MapVM()
    let addTravelVC = AddTravelVC()
    
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.mapType = MKMapType.standard
        mv.isZoomEnabled = true
        mv.isScrollEnabled = true
        mv.delegate = self
        return mv
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 18
        flowLayout.minimumInteritemSpacing = 18
        let cv = UICollectionView(frame: .zero,collectionViewLayout: flowLayout)
        cv.register(MapCollectionCell.self, forCellWithReuseIdentifier: "map")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initVM()
        initAddTravelVC()
        
    // FIXME: - alltaki iki satırı viewDidload'dan çıkar.
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
                  let touchPoint = sender.location(in: mapView)
                  let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let vc = AddTravelVC()
            vc.latitude = touchCoordinate.latitude
            vc.longitude = touchCoordinate.longitude
            present(vc, animated: true)
              }
    }
    
    func initVM() {
        viewModal.getLocations()
        viewModal.fillMapp = { locations in
            
            self.configure(locations: locations)
        }
        viewModal.reloadCell = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
       
        
    }
    
    func initAddTravelVC() {
        addTravelVC.reloadMapVC = {
            self.initVM()
        }
    }
     
    
    func configure(locations: [PlaceItem]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = location.title
            
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = Color.systemGreen.chooseColor
        view.addSubViews(mapView,collectionView)
        setupLayout()
    }
    
    private func setupLayout() {
        mapView.edgesToSuperview()
        
        collectionView.edgesToSuperview(excluding: [.top], insets: .left(18) + .bottom(101))
        collectionView.height(178)
    }
    
    func pushNav(item: PlaceItem) {
        let detailVC = DetailVC()
        detailVC.viewModal = DetailVM(id: item.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customAnnotation = view.annotation as? MKPointAnnotation {
            let region = MKCoordinateRegion(center: customAnnotation.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
            mapView.setRegion(region, animated: false)
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKAnnotation else {
            return nil
        }
        
        let identifier = "customAnnotation"
        var annotationView: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            dequeuedView.annotation = annotation
            annotationView = dequeuedView
        } else {
            // Use MKAnnotationView instead of MKPinAnnotationView
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            
            // Set the custom annotation image
            annotationView.image = UIImage(named: "mapIcon")
            
            let button = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = button
        }
        
        return annotationView
        
        print("deneme")
        print("kaanDeneme")
    }




    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
           if let annotation = view.annotation as? MKAnnotation {
               print("İşaretin başlığı: \(annotation.title ?? "")")
               print("İşaretin alt başlığı: \(annotation.subtitle ?? "")")
               // Burada yapmak istediğiniz eylemi gerçekleştirebilirsiniz
           }
       }


}


extension MapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {// size vermemiz gereikyor çünkkü ve genişlik ve yükseklik değerlerinie ihiyacımız var.
        let size = CGSize(width: 309, height: (collectionView.frame.height))
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModal.getObjectForRow(indexpath: indexPath) else {return}
       pushNav(item: item)
    }
}

extension MapVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal.NumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "map", for: indexPath) as? MapCollectionCell else {return UICollectionViewCell()}

        guard let object = viewModal.getObjectForRow(indexpath: indexPath) else { return cell}
        cell.configure(item: object)
    
        return cell
    }
    
    
}
