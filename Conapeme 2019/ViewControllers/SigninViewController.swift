//
//  SigninViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Disk

class SigninViewController:UIViewController {
    
    var nl = CPMNetworkLayer()
    weak var delegate:SigninViewControllerDelegate?
    
    var topBanner:UIView  = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 31/255, green: 157/255, blue: 200/255, alpha: 1)
        return v
    }()
    
    var logo:UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "logo")
        return i
    }()
    
    var logo2:UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = UIImage(named: "logo_2")
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    let descriptionLabel:UILabel = {
        let l = UILabel()
        l.text = "Confederación Nacional De Pediatría De México"
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 2
        l.textAlignment = .center
        l.textColor = .white
        
        return l
    }()
    
    let signinButton:UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor(.white, for: .normal)
        b.setTitle("Entrar", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        b.backgroundColor =  UIColor.CPMGreen
        b.layer.cornerRadius = 5
        b.heightAnchor.constraint(equalToConstant: 44)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let backButton:UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor( UIColor.lightGray, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        b.setTitle("Regresar", for: .normal)
        b.layer.borderColor =  UIColor.lightGray.cgColor
        b.layer.borderWidth = 0.5
        b.layer.cornerRadius = 5
        b.heightAnchor.constraint(equalToConstant: 44)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let typeUserSegment:UISegmentedControl =  {
        let s = UISegmentedControl(items: ["Asistente","Expositor"])
        s.selectedSegmentIndex = 0
        s.translatesAutoresizingMaskIntoConstraints = false
        s.tintColor = UIColor.CPMGreen
        return s
    }()
    
    let fastSigninButton:UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor( UIColor.CPMGreen, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        b.setTitle("Inicio Rapido", for: .normal)
        b.layer.borderColor =  UIColor.CPMGreen.cgColor
        b.layer.borderWidth = 0.5
        b.layer.cornerRadius = 5
        b.heightAnchor.constraint(equalToConstant: 44)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var loginField:CPMTextField = {
        let tf = CPMTextField(placeholder: "No. de Registro",isSecure:false)
        return tf
    }()
    
    var passwordField:CPMTextField = {
        let tf = CPMTextField(placeholder: "Contraseña",isSecure:true)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        layoutSubViews()
    }
    
    func setupSubViews()  {
        view.backgroundColor = .white
        view.addSubview(topBanner)
        view.addSubview(logo)
        view.addSubview(loginField)
        view.addSubview(signinButton)
        view.addSubview(fastSigninButton)
        view.addSubview(typeUserSegment)
        view.addSubview(backButton)
        typeUserSegment.addTarget(self, action: #selector(valueOfSegmentChanged), for: UIControl.Event.valueChanged)
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        fastSigninButton.addTarget(self, action: #selector(showFastSigninController), for: .touchUpInside)
        topBanner.addSubview(logo2)
        topBanner.addSubview(descriptionLabel)
    }
    
    @objc func valueOfSegmentChanged(){
        let index = typeUserSegment.selectedSegmentIndex
        if(index == 1) {
            fastSigninButton.isEnabled = false
            fastSigninButton.alpha = 0
        } else {
            fastSigninButton.isEnabled = true
            fastSigninButton.alpha = 1
        }
    }
    
    func layoutSubViews(){
        topBanner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBanner.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logo.topAnchor.constraint(equalTo: topBanner.bottomAnchor,constant:32).isActive = true
        logo.centerXAnchor.constraint(equalTo: topBanner.centerXAnchor).isActive = true
        
        logo2.leadingAnchor.constraint(lessThanOrEqualTo: topBanner.leadingAnchor,constant:8).isActive = true
        logo2.bottomAnchor.constraint(lessThanOrEqualTo: topBanner.bottomAnchor,constant:-8).isActive = true
        logo2.heightAnchor.constraint(equalToConstant: 44).isActive = true
        logo2.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        typeUserSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        typeUserSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        typeUserSegment.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32).isActive = true
        
        
        descriptionLabel.leadingAnchor.constraint(equalTo: logo2.trailingAnchor, constant: 0).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: logo2.centerYAnchor, constant: 0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: topBanner.trailingAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        loginField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        loginField.topAnchor.constraint(equalTo: typeUserSegment.bottomAnchor, constant: 8).isActive = true
        
        signinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        signinButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        signinButton.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 8).isActive = true
        signinButton.addTarget(self, action: #selector(signin), for: .touchUpInside)
        
        fastSigninButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        fastSigninButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        fastSigninButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 8).isActive = true
        
        backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    }
    
    @objc func showFastSigninController() {
        let vc = FastSigninViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func showError(message:String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @objc func signin(){
        guard let id = loginField.text else {
            return
        }
        
        let index = typeUserSegment.selectedSegmentIndex
        if(index == 0) {
            nl.fastSignin(asisstantId: id) { (response,err)  in
                if(err != nil){
                    self.showError(message: "Verifique su conexión a internet y vuelva a intentarlo")
                    return
                }
                self.handleAssistantResponse(response: response!)
            }
        } else {
            nl.expositorSignin(expositorId: id) { (response,err)  in
                if(err != nil){
                    self.showError(message: "Verifique su conexión a internet y vuelva a intentarlo")
                    return
                }
                self.handleExpositorResponse(response: response!)
            }
        }
        
    }
    
    func handleExpositorResponse(response:ExpositorSigninResponse){
        switch response.code {
        case 200:
            guard let expositor = response.result else {
                return
            }
            let credentials = Credentials(userId:expositor.id_expositor!,userType:0,virtual:0)
            saveCredentialsToDisk(credentials: credentials)
        case 400:
            loginErrorAlert(message: response.errorMessage ?? "Error al iniciar sesión")
        default :
            return
        }
    }
    
    func handleAssistantResponse(response:FastSigninResponse){
        switch response.code {
        case 200:
            guard let assistant = response.result else {
                return
            }
            let credentials = Credentials(userId:assistant.id!,userType:1,virtual:assistant.virtual!.data[0])
            saveCredentialsToDisk(credentials: credentials)
        case 400:
            loginErrorAlert(message: response.errorMessage ?? "Error al iniciar sesión")
        default :
            return
        }
    }
    
    func loginErrorAlert(message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveCredentialsToDisk(credentials:Credentials){
        do {
            try Disk.save(credentials, to: Disk.Directory.documents, as: "credentials.json")
            dismiss(animated: true) {
                self.delegate?.signinWasSuccesful()
            }
        } catch {
            print("err")
        }
    }
    
}




extension SigninViewController:FastSigninDelegate{
    func userDidScannQRCode(assistantId: String) {
        nl.fastSignin(asisstantId: assistantId) { (response,err)  in
            if(err != nil){
                self.showError(message: "Verifique su conexión a internet y vuelva a intentarlo")
                return
            }
            self.handleAssistantResponse(response: response!)
        }
    }
    
    
}
