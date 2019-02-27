//
//  HotelsListViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit

class HotelsListViewController:UIViewController {
    
    var dataSource:HotelsListDataSource?
    
    var hotelTable:UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.register(HotelCell.self, forCellReuseIdentifier: "hotelCell")
        tv.backgroundColor = .white
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupNavitagionItems()
        setupTableView()
        extendedLayoutIncludesOpaqueBars = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupTableView(){
        hotelTable.dataSource = dataSource
        hotelTable.delegate = dataSource
        view.addSubview(hotelTable)
        hotelTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        hotelTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hotelTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hotelTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupNavitagionItems(){
        navigationItem.title = "Hoteles"
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        if let url = Bundle.main.url(forResource: "hoteles", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HotelsResponse.self, from: data)
                dataSource = HotelsListDataSource(hotels: jsonData.hotels)
            } catch {
                print("error:\(error)")
            }
        }
    }
}


class HotelsListDataSource :NSObject,UITableViewDataSource,UITableViewDelegate{
    
    var hotels:[Hotel]
    
    init(hotels:[Hotel]) {
        self.hotels = hotels
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let hotel = hotels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath) as! HotelCell
        cell.hotel = hotel
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let imageHeight = UIScreen.main.bounds.width
        return 62 + imageHeight
    }
    
    
}


import PINRemoteImage

class HotelCell:UITableViewCell {
    
    var nameLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 25)
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    
    var descriptionLabel:UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 13)
        l.textColor = UIColor.lightGray
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    var photo:UIImageView = {
        let p = UIImageView(frame: .zero)
        p.translatesAutoresizingMaskIntoConstraints = false
        p.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        p.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        p.contentMode = .scaleAspectFit
        return p
    }()
    
    var hotel:Hotel? {
        didSet{
            nameLabel.text = hotel!.name
            photo.pin_setImage(from: URL(string: (hotel?.img_uri)!))
            descriptionLabel.text = hotel!.available ?  hotel!.description : "Agotado"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
    }
    
    func setupViews(){
        addSubview(nameLabel)
        addSubview(photo)
        addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        photo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        photo.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
