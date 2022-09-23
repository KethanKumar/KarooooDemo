//
//  TitleLabel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit

class TitleLabel: UILabel {


    @IBInspectable
    var fontSize: CGFloat = 22.0 {
        didSet {
            self.font = UIFont.systemFont(ofSize: fontSize)
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


private extension TitleLabel {

    func configure() {
        adjustAppearence()
    }

    func adjustAppearence() {
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = labelColor
    }

}

