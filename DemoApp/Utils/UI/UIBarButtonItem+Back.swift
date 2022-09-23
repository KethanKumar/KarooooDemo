//
//  UIBarButtonItem+Back.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit
import SwiftUI

extension UIBarButtonItem {
    static func backBarButtonItem(withColor color: UIColor, image: UIImage = #imageLiteral(resourceName: "back"), tapHandler handler: @escaping () -> Void) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        item.tintColor = color
        _ = item.reactive.tap.observeNext {
            handler()
        }
        return item
    }

    static func imageBarButtonItem(withImage image: UIImage, andColor color: UIColor, tapHandler handler: @escaping () -> Void) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        item.tintColor = color
        _ = item.reactive.tap.observeNext {
            handler()
        }
        return item
    }

    static func textBarButtonItem(withTitle title: String, andTextColor textColor: UIColor, tapHandler handler: @escaping () -> Void) -> UIBarButtonItem {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
        ]
        let disabledTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)
        ]
        let item = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        item.setTitleTextAttributes(textAttributes, for: .normal)
        item.setTitleTextAttributes(textAttributes, for: .highlighted)
        item.setTitleTextAttributes(disabledTextAttributes, for: .disabled)
        _ = item.reactive.tap.observeNext {
            handler()
        }
        return item
    }
}

// MARK: - Notification badge icon add / remove

private var handle: UInt8 = 0

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }

    func addBadge() {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        badgeLayer?.removeFromSuperlayer()
        let badge = CAShapeLayer()
        let radius = CGFloat(4)
        let location = CGPoint(x: view.frame.width - (7), y: (7))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: .red, filled: true)
        view.layer.addSublayer(badge)
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}

extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}
