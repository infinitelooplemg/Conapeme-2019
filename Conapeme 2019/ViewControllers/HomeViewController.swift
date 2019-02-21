//
//  HomeViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import Disk

class HomeViewController:ASViewController<ASDisplayNode> {
    
    weak var container:MasterViewController?
    var credentials:Credentials? = nil
    var sideMenu:SideMenu? = nil
    var homenode:HomeNode!
    
    init(container:MasterViewController) {
        homenode = HomeNode()
        self.container = container
        super.init(node: homenode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readCredentials()
        initializeSideMenu()
        initializeNavigationBar()
    }
    
    
    func initializeSideMenu(){
        let items = (credentials == nil) ? GuestMenuItems : AssitantMenuItems
        sideMenu = SideMenu(home: self, items: items)
    }
    
    func initializeNavigationBar(){
        let resetContainerButton = UIBarButtonItem(title: "Perfil", style: .done, target: self, action: #selector(profileButtonPressed))
        navigationItem.rightBarButtonItem = resetContainerButton
        let menuButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func toggleMenu (){
        
        sideMenu?.toggle(completion: nil)
    }
    
    @objc func profileButtonPressed(){
        if (credentials == nil) {
            presentSigninViewController()
        } else {
            presentUserProfileViewController()
        }
    }
    
    func presentSigninViewController(){ 
        let vc = SigninViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func presentUserProfileViewController(){
        let vc = UserProfileViewController()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    @objc func resetContainer(){
        sideMenu?.removeFromSuperview()
        sideMenu = nil
        container?.resetHomeMenu()
    }
    
    func readCredentials(){
        do {
            credentials =  try  Disk.retrieve("credentials.json", from: Disk.Directory.documents, as: Credentials.self)
        } catch  {
        }
    }
    
    func presentVCFor(menuItem:MenuItem){
        switch menuItem {
        case .fechaEvento:
            presentVC(vc: EventDateViewController())
        case .sede:
            presentVC(vc: EventLocationViewController())
        case .planoCongreso:
            presentVC(vc: EventPlaneViewController())
        case .manualExpositor:
            presentVC(vc: ExpositorsManualViewController())
        case .programaGeneral:
            presentVC(vc: ScheduleViewController())
        case .hoteles:
            presentVC(vc: HotelsListViewController())
        case .montaje:
            presentVC(vc: MontajeViewController())
//        case .live:
//            presentVC(vc: LiveViewController())
        default:
            print("default")
        }
    }
    
    
    func presentVC(vc:UIViewController){
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
}

extension HomeViewController:SigninViewControllerDelegate{
    func signinWasSuccesful() {
        resetContainer()
    }
}

extension HomeViewController:SignouDelegate{
    func userDidSignout() {
        resetContainer()
    }
}
