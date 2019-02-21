
import UIKit

class SideMenuItemCell: UITableViewCell {
    var titleLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.boldSystemFont(ofSize: 13)
        l.heightAnchor.constraint(equalToConstant: 44).isActive = true
        l.textColor = .white
        return l
    }()
    
    var iconImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 25).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.image = UIImage(named: "calendar")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var title:String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var menuItem:MenuItem? {
        didSet {
            titleLabel.text = menuItem?.description
            iconImage.image = menuItem?.icon
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func setupViews(){
        addSubview(titleLabel)
        addSubview(iconImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8 ).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//  SideMenuItemCell.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
