//
//  WorkshopsInteractiveViewController.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/11/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class WorkshopsInteractiveViewController:ASViewController<ASTableNode> {
    var tableNode:ASTableNode
    var nl = CPMNetworkLayer()
    var workShops:[Workshop] = []
    var filteredWorkShops = [Workshop]()
    
    var isFiltering = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init() {
        tableNode = ASTableNode()
        super.init(node: tableNode)
        tableNode.dataSource = self
        loadWorkshops()
        node.backgroundColor = .white
    }
    
    func loadWorkshops(){
        nl.fetchWorkshops { (workshops, error) in
            if((error) != nil){
                return
            }
            self.workShops = workshops!
            self.tableNode.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.view.separatorStyle = .none
        setupNavigationButtons()
        navigationItem.title = "Talleres"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setupSearchController()
    }
    
    func setupSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.white
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
    
    func setupNavigationButtons(){
        let cancelButton = UIBarButtonItem(title: "Regresar", style: UIBarButtonItem.Style.plain, target: self , action: #selector(dismisViewController))
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        
        navigationController?.navigationBar.barTintColor = UIColor.CPMGreen
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func dismisViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func filterContentForSearchText(_ searchText:String) {
        filteredWorkShops = workShops.filter({ workshop -> Bool in
            return workshop.topic.lowercased().contains(searchText.lowercased())
        })
        tableNode.reloadData()
        
    }
    
    
    func presentRegisterAssistantVC(workshopId:Int){
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success {
                DispatchQueue.main.async {
                    let vc = RegisterAssistanceViewController()
                    vc.workshopId = workshopId
                    self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Camera", message: "Necesitamos nos permitas acceder a tu cámara para poder registrar participantes en los talleres", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    
}

extension WorkshopsInteractiveViewController:ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredWorkShops.count
        }
        return workShops.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let workshop:Workshop
        if isFiltering {
            workshop = filteredWorkShops[indexPath.row]
        } else {
            workshop = workShops[indexPath.row]
        }
        
        let cellNodeBlock = { [weak self]() -> ASCellNode in
            let cellNode = WorkshopCellNode(workshop: workshop,delegate:self!)
            return cellNode
        }
        return cellNodeBlock
    }
    
}


extension WorkshopsInteractiveViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
        isFiltering = true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        isFiltering = true
        searchBar.resignFirstResponder()
        
        guard let term = searchBar.text , term.isEmpty == false else {
            return
        }
        
        filterContentForSearchText(term)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
        isFiltering = false
        tableNode.reloadData()
    }
    
}


extension WorkshopsInteractiveViewController:WorkshopCellNodeDelegate {
    func takeAssitanceFor(workshopId: Int) {
        presentRegisterAssistantVC(workshopId: workshopId)
    }
    
    func showAssitanceListFor(workshopId: Int) {
        let vc = WorkshopAssistantsViewController()
        vc.workshopId = workshopId
        
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}
