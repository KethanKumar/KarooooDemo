//
//  RefreshControl.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class RefreshControl: UIRefreshControl {

//    private let animaitonView = AnimationView()

    override init() {
        super.init()
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func beginRefreshing() {
        super.beginRefreshing()
//        animaitonView.animateLoading()
    }
}

private extension RefreshControl {

    func configure() {
        backgroundColor = .clear
        tintColor = .clear
//        addSubview(animaitonView)
//        animaitonView.center(to: self)
//        animaitonView.setSize(40, 40)
//        animaitonView.animateLoading()
    }
}
