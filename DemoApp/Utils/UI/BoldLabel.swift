//
//  BoldLabel.swift
//  DemoApp
//
//  Created by Kethan Kumar on 05/09/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class BoldLabel: UILabel {


    @IBInspectable
    var fontSize: CGFloat = 18.0 {
        didSet {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var labelColor: UIColor = .blue {
        didSet {
            self.textColor = self.labelColor
            self.setNeedsDisplay()
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

}


private extension BoldLabel {

    func configure() {
        adjustAppearence()
    }

    func adjustAppearence() {
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.textColor = labelColor
    }

}

