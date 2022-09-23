//
//  RefreshControl.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit
import Lottie

class RefreshControl: UIRefreshControl {

    private let animaitonView = AnimationView()

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
        addSubview(animaitonView)
        animaitonView.center(to: self)
        animaitonView.setSize(40, 40)
        animaitonView.animateLoading()
    }
}
