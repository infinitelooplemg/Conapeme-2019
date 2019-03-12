//
//  RegisterAssistanceViewController.swift
//  Conapeme 2019
//
//  Created by Usuario on 3/11/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RegisterAssistanceViewController: UIViewController {
    
    var video = AVCaptureVideoPreviewLayer()
    
    var qrCodeString:String? = nil
    
    let captureSession = AVCaptureSession()
    
    var isScanning = false
    
    var workshopId:Int? = nil
    
    var nl = CPMNetworkLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDeviceCamera()
        setupNavigationButtons()
        navigationController?.navigationBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true
        
        navigationItem.title = "Registro"
        navigationController?.navigationBar.barTintColor = UIColor.CPMGreen
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.backgroundColor = .black
        
    }
    
    
    
    func getDeviceCamera(){
        let defaultDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: defaultDevice!)
            captureSession.addInput(input)
        }
        catch {
            print ("ERROR")
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: captureSession)
        video.frame = view.layer.frame
        view.layer.addSublayer(video)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
        
        let titleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
        self.navigationItem.titleView?.addGestureRecognizer(titleTapRecognizer)
        
    }
    
    @objc func titleTapped(){
        let vc = WorkshopsInteractiveViewController()
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func setupNavigationButtons(){
        let cancelButton = UIBarButtonItem(title: "Regresar", style: UIBarButtonItem.Style.plain, target: self , action: #selector(dismisViewController))
        navigationItem.setLeftBarButton(cancelButton, animated: true)
    }
    
    
    
    @objc func dismisViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func register(assistantId:String){
        nl.addAssistanceToWorkshop(assistantId: Int(assistantId)!, workshopId: self.workshopId!, logisticsId: "154864b4-20bf-11e8-8d88-a4bf0107c510") { (result, error) in
            if(error != nil){
                self.showInternetErrorMessage()
                return
            }
            
            guard let response = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.handleResponse(response: response)
            }
            
            
        }
    }
    
    func showInternetErrorMessage(){
        print("error de internet")
    }
    
    func handleResponse(response:GenericSuccesResponse<SQLResult>){
        switch response.code {
        case 200:
            showSuccesMessage()
            break
        case 400:
            showErrorMessage(sqlError: response.sqlError!)
        default: break
        }
    }
    
    func showErrorMessage(sqlError:SQLError){
        
        let message = SQLErrorCode(rawValue: sqlError.errno)
        
        let alertController = UIAlertController(title: "Error", message: message?.description, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.isScanning = false
        }
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showSuccesMessage(){
        let alertController = UIAlertController(title: "Felicidades", message: "El asistente fue registrado con exito", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.isScanning = false
        }
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterAssistanceViewController:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count != 0 else {
            return
        }
        
        guard let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        guard object.type == AVMetadataObject.ObjectType.qr else {
            return
        }
        qrCodeString = object.stringValue
        if(!isScanning){
            isScanning = true
            DispatchQueue.main.async {
                self.register(assistantId: self.qrCodeString!)
            }
        }
    }
}
