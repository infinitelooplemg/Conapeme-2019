import UIKit
import MapKit


class EventLocationViewController: UIViewController {
    
    var mapView:MKMapView = {
        let m = MKMapView(frame: .zero)
        m.translatesAutoresizingMaskIntoConstraints = false
        return m
    }()
    
    var infoView:UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let v = UIVisualEffectView(effect: blurEffect)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 5
        return v
    }()
    
    var addressLabel:UILabel = {
        let l = UILabel()
        l.text = "Mariano Otero 1499, Guadalajara, Jalisco, Mexico"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13)
        l.adjustsFontSizeToFitWidth = true
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    var placeNameLabel:UILabel = {
        let l = UILabel()
        l.text = "Expo Guadalajara"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 25)
        l.adjustsFontSizeToFitWidth = true
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavitagionItems()
        navigationItem.title = "Sede"
        centerMap()
        setupSubviews()
        layoutSubviews()
    }
    
    func setupSubviews(){
        view.addSubview(mapView)
        view.addSubview(infoView)
        infoView.contentView.addSubview(addressLabel)
        infoView.contentView.addSubview(placeNameLabel)
    }
    
    func layoutSubviews(){
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant:-8).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 8).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        placeNameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 8).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 8).isActive = true
        placeNameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -8).isActive = true
        placeNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    
    
    func centerMap(){
        let theSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
        let pointLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(20.6527, -103.3921)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: pointLocation, span: theSpan)
        self.mapView.setRegion(region, animated: true)
        
        
        let expo : CLLocationCoordinate2D = CLLocationCoordinate2DMake(20.6527, -103.3921)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = expo
        
        objectAnnotation.title = "Expo Guadalajara"
        self.mapView.addAnnotation(objectAnnotation)
    }
    
    
    func setupNavitagionItems(){
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
    
}//
//  EventLocationViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
