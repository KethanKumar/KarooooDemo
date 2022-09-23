//
//  ApiService+image.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class ApiService {
    func getImage(fromURL url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image, url)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, url)
                }
            }
        }
        task.resume()
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
