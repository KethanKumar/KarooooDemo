//
//  ImagePickerCOntroller.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import Foundation
import Photos
import UIKit

enum PictureSource {
    case camera
    case gallery
}

class ImagePickerManager {

    func pickImage(source: PictureSource, picker: UIImagePickerController) {
        picker.allowsEditing = false
        guard let topVC = UIApplication.getTopViewController() else { return }
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                if source == .camera {
                    DispatchQueue.main.async {
                        if UIImagePickerController.isSourceTypeAvailable(.camera) {
                            picker.sourceType = .camera
                            topVC.present(picker, animated: true, completion: nil)
                        } else {
                            debugPrint("No camera detected")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        picker.sourceType = .photoLibrary
                        topVC.present(picker, animated: true, completion: nil)
                    }
                }
            default:
                debugPrint("status unhandled: \(status) ")
            }
        }
    }
}
extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

