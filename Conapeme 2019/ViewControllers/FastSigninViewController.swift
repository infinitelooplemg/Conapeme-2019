//
//  FastSigninViewController.swift
//  Conapeme
//
//  Created by FABY on 2/11/19.
//  Copyright © 2019 Grupo Lider. All rights reserved.
//
import Foundation
import UIKit
import AVFoundation

class FastSigninViewController: UIViewController {
    
    var video = AVCaptureVideoPreviewLayer()
    weak var delegate:FastSigninDelegate?
    
    var qrCodeString:String? = nil
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        getDeviceCamera()
        setupNavigationButtons()
    }
    
    func setupSubViews(){
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
        showTutorialAlert()
        
    }
    
    func setupNavigationButtons(){
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self , action: #selector(dismisViewController))
        navigationItem.setLeftBarButton(cancelButton, animated: true)
    }
    
    
    
    @objc func dismisViewController(){
        dismiss(animated: true, completion: nil)
    }
    
    func showTutorialAlert(){
        let alertController = UIAlertController(title: "Inicio Rapido", message: "Apunta con tu celular al codigo QR que se encuentra en la parte frontal de tu gafete", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in
            self.captureSession.startRunning()
        }
        
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension FastSigninViewController:AVCaptureMetadataOutputObjectsDelegate{
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
        
        guard qrCodeString == nil else {
            return
        }
        
        qrCodeString = object.stringValue
       
//        dismisViewController()
        
        dismiss(animated: true) {
            self.delegate?.userDidScannQRCode(assistantId: self.qrCodeString!)
        }
        
    }
}
