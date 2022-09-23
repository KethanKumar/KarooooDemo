//
//  NibView.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit

class NibView: UIView {

    private(set) var loadedView: UIView!
    private var nibName: String {
        return type(of: self).description().components(separatedBy: ".").last!
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        loadedView = loadViewFromNib()
        loadedView.frame = bounds
        loadedView.backgroundColor = .clear
        //loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(loadedView)
        loadedView.pin(to: self)
        awakeFromNib()
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
