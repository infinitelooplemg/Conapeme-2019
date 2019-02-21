
import UIKit

class SideMenuTableView:UITableView {
    
    weak var menu:SideMenu?
    var items:[MenuItem]!
    
    init(menu:SideMenu,items:[MenuItem]) {
        super.init(frame: .zero, style: UITableView.Style.plain)
        self.items = items
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        separatorStyle = .none
        self.menu = menu
        
        register(SideMenuItemCell.self, forCellReuseIdentifier: "menuItem")
        delegate = self
        dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SideMenuTableView:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath) as! SideMenuItemCell
        cell.menuItem = menuItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        menu?.didSelectItem(item: item)
    }
    
}
//
//  SideMenuTableView.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
