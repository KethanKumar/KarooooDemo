//
//  ShareView.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

struct ShareControllerViewModel {
    var textToShare: String?
    var url: URL?
    var imageToShare: UIImage?
}

enum ShareViewController {
    static func buildShareView(withViewModel viewModel: ShareControllerViewModel) -> UIActivityViewController? {
        UIGraphicsEndImageContext()
        if let url = viewModel.url {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            return activityVC
        }
        if let text = viewModel.textToShare {
            let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            return activityVC
        }
        return nil
    }
}
