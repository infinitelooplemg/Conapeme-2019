//
//  EventPlaneViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit

class EventPlaneViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView:UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.maximumZoomScale = 1
        sv.minimumZoomScale = 1
        sv.zoomScale = 1
        return sv
    }()
    
    var mapImage:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "map"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Plano"
        setupNavitagionItems()
        setupViews()
        layoutSubviews()
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupNavitagionItems(){
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupViews(){
        view.addSubview(mapImage)
    }
    
    func layoutSubviews(){
        
        mapImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImage
    }
}
