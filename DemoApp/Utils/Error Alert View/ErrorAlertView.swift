//
//  ErrorAlertView.swift
//  Medsi
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit
import Bond


class ErrorAlertView: NibView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var topLayerView: UIView!

    func configure(with viewModel: ErrorAlertViewModel, viewController: UIViewController) {
        viewModel.notificationTitle.bind(to: titleLabel.reactive.text)
        viewModel.notificationMessage.bind(to: messageLabel.reactive.text)
        viewModel.textColor.bind(to: titleLabel.reactive.textColor)
        viewModel.textColor.bind(to: messageLabel.reactive.textColor)
        self.backgroundColor = .red
        createPanGestureRecognizer()
        self.show(viewController: viewController)
    }
}

private extension ErrorAlertView {
    private func show(viewController: UIViewController) {
        guard let window = UIApplication.shared.delegate?.window else { return }

        window?.windowLevel = UIWindow.Level.statusBar
        window?.addSubview(self)
        window?.bringSubviewToFront(self)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            var frame = self.frame

            frame.origin.y += frame.size.height
            self.frame = frame
        }, completion: nil)
        self.hide()
    }

    private func hide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.manualHide(completion: nil)
        }
    }

    private func manualHide(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            var frame = self.frame
            frame.origin.y -= frame.size.height
            self.frame = frame
        }, completion: { _ in
            self.removeFromSuperview()
            UIApplication.shared.delegate?.window??.windowLevel = UIWindow.Level.normal
            completion?()
        })
    }

    func createPanGestureRecognizer() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ErrorAlertView.swipedUp))
        swipeUp.direction = .up
        self.topLayerView.addGestureRecognizer(swipeUp)
    }

    @objc func swipedUp() {
        self.manualHide(completion: nil)
    }
}
