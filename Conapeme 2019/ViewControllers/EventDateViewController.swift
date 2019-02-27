import UIKit

class EventDateViewController: UIViewController {
    
    var bannerImage:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var headerLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.heightAnchor.constraint(equalToConstant: 88).isActive = true
        l.text = "51 Congreso Nacional de Peidiatría CONAPEME"
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textColor = .white
        l.numberOfLines = 2
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    
    
    var drNameLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.heightAnchor.constraint(equalToConstant: 44).isActive = true
        l.text = "Dr. Salvador Jáuregi Pulido"
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.textColor = .white
        l.numberOfLines = 2
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    
    var dateLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.heightAnchor.constraint(equalToConstant: 44).isActive = true
        l.text = "Del 2 al 5 de Mayo 2019"
        l.font = UIFont.boldSystemFont(ofSize: 13)
        l.textColor = .white
        l.numberOfLines = 2
        l.textAlignment = .center
        l.sizeToFit()
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.CPMGreen
        navigationItem.title = "Fechas"
        setupNavitagionItems()
        setupSubViews()
        layoutSubviews()
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupSubViews() {
        view.addSubview(bannerImage)
        view.addSubview(headerLabel)
        view.addSubview(drNameLabel)
        view.addSubview(dateLabel)
    }
    
    func layoutSubviews(){
        let img = UIImage(named: "baby")
        let aspectRatio = img!.size.width / img!.size.height
        let requiredHegiht = view.bounds.width / aspectRatio
        bannerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bannerImage.heightAnchor.constraint(equalToConstant: requiredHegiht).isActive = true
        bannerImage.image = img
        
        headerLabel.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 32).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        
        drNameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 0).isActive = true
        drNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        drNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    
    
    func setupNavitagionItems(){
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
}//
//  EventDateViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
