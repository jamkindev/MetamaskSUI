//
//  CameraViewController.swift
//  MetamaskSUI
//
//  Created by jamkin on 2022/7/7.
//

import UIKit
import SwiftUI


final class CameraViewController: UIViewController {
    let cameraController = CameraController()
    var previewView: UIView!
    
    override func viewDidLoad() {
                
        previewView = UIView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(previewView)
        
        let btn: UIButton = UIButton.init(frame: CGRect(x:UIScreen.main.bounds.size.width - 15 - 60, y:44, width: 60, height: 60))
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        btn.setImage(UIImage.init(systemName: "xmark"), for: .normal)
        view.addSubview(btn)
        
        let img: UIImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.width - 30))
        img.image =  UIImage.init(systemName: "camera.metering.center.weighted.average")!
        img.center = self.view.center;
        view.addSubview(img)


        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.previewView)
        }
        
    }
    
    @objc func click(sender: UIButton){
        self.dismiss(animated: true)
    }
}


extension CameraViewController : UIViewControllerRepresentable{
    public typealias UIViewControllerType = CameraViewController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraViewController>) -> CameraViewController {
        return CameraViewController()
    }
    
    public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraViewController>) {
    }
}
