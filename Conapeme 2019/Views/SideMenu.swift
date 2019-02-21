//
//  SideMenu.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import UIKit


class SideMenu:UIView {
    let windowView = UIApplication.shared.keyWindow!
    var isPresented = false
    var leadingConstraint:NSLayoutConstraint?
    var itemsTableView :SideMenuTableView!
    var items:[MenuItem]!
    weak var home:HomeViewController?
    
    var blackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.alpha = 0
        return v
    }()
    
    init(home:HomeViewController,items:[MenuItem]) {
        super.init(frame: .zero)
        self.home = home
        self.items = items
        translatesAutoresizingMaskIntoConstraints = false
        windowView.addSubview(blackView)
        windowView.addSubview(self)
        setupConstraints()
        setupGestureRecognizer()
        setupTableView()
        backgroundColor = UIColor.CPMGreen
    }
    
    
    
    func setupTableView() {
        itemsTableView = SideMenuTableView(menu: self, items: items)
        addSubview(itemsTableView)
        itemsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupGestureRecognizer() {
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        blackView.addGestureRecognizer(tapRecogniser)
    }
    
    func setupConstraints(){
        leadingConstraint = leadingAnchor.constraint(equalTo: windowView.leadingAnchor, constant: -230)
        leadingConstraint?.isActive = true
        alpha = 0
        widthAnchor.constraint(equalToConstant: 230).isActive = true
        topAnchor.constraint(equalTo: windowView.topAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: windowView.bottomAnchor).isActive = true
        
        blackView.frame = windowView.frame
    }
    
    @objc func hideMenu (){
        toggle(completion: nil)
    }
    
    
    @objc func toggle(completion:  (() -> ())?) {
        leadingConstraint?.constant = (isPresented == true) ?  -230 : 0
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.windowView.layoutIfNeeded()
            self.alpha = (self.isPresented == true) ?  0 : 1
            self.blackView.alpha = (self.isPresented == true) ?  0 : 0.7
        }) { finished in
            if(completion != nil) {
                completion!()
            }
            self.isPresented = !self.isPresented
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSelectItem(item:MenuItem) {
        toggle {
            self.home?.presentVCFor(menuItem: item)
        }
    }
}
