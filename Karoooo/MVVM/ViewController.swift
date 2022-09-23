//
//  ViewController.swift
//  DemoApp
//
//  Created by Kethan Kumar on 20/09/2022.
//


import UIKit

protocol ViewController: UIViewController {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
    static func instantiate() -> Self
}

extension ViewController {

    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}
