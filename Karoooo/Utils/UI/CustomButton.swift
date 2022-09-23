//
//  DCUButton.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit
import Bond

enum AnimationStatus {
    case defaultStatus
    case loading
}

@IBDesignable
class CustomButton: UIButton {

    private var fontSize: CGFloat = 0

    private var animatedTitleLabel = UILabel()
    private var cachedTitle: String?
    private var originalBounds = CGRect.zero
    private var activityIndicator: UIActivityIndicatorView!
    private var backgroundStatusView = UIView()
    private var statusImageView = UIImageView()
    private var originalButtonText: String?
    let loadingStatus = Observable<AnimationStatus>(.defaultStatus)

    @IBInspectable var dropsShadow: Bool = false {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var enabledBackgroundColor: UIColor = .blue {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var disabledBackgroundColor: UIColor = .lightGray {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 22.5 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowOpacity: Float = 10.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowOffsetHeight: CGFloat = 5.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 3.0 {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var isAnimable: Bool = false {
        didSet {
            adjustAppearence()
        }
    }

    @IBInspectable var titleColor: UIColor = .white

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

    override var isEnabled: Bool {
        didSet {
            adjustAppearence()
        }
    }
}

private extension CustomButton {

    func adjustAppearence() {
        backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
        alpha = isEnabled ? 1 :  0.9
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        setTitleColor(titleColor, for: .normal)
        configureAnimatedLabel()
    }

    func configure() {
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 225.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: shadowOffsetHeight)
        adjustAppearence()
    }

    func configureAnimatedLabel() {
        if self.superview != nil {
            animatedTitleLabel.backgroundColor = .clear
            animatedTitleLabel.textAlignment = .center
            animatedTitleLabel.alpha = 0.0
            self.superview?.addSubview(animatedTitleLabel)
        }
    }

    func prepareAnimatedLabelForAnimation() {
        let animatedTitleLabelFrame = self.convert(self.titleLabel!.frame, to: self.superview)
        animatedTitleLabel.frame = animatedTitleLabelFrame
        animatedTitleLabel.textColor = self.titleLabel?.textColor
        animatedTitleLabel.font = self.titleLabel?.font
        animatedTitleLabel.text = self.titleLabel?.text
        animatedTitleLabel.alpha = 1.0
        cachedTitle = self.titleLabel?.text
        self.setTitle("", for: .normal)
        self.titleLabel?.alpha = 0.0
    }

    func setHighlighted(_ highlighted: Bool) {
        if highlighted {
            titleLabel?.alpha = 0.6
            imageView?.alpha = 0.6
        } else {
            titleLabel?.alpha = 1
            imageView?.alpha = 1
        }
    }
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }

    func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

    func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
}

extension CustomButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        fontSize = titleLabel?.font.pointSize ?? 0
        setHighlighted(true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setHighlighted(false)
        guard let eventType = event?.type, eventType == .touches else { return }
        if (touches.first { bounds.contains($0.location(in: self)) }) == nil {
            super.touchesCancelled(touches, with: event)
        } else {
            super.touchesEnded(touches, with: event)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        setHighlighted(false)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let eventType = event?.type, eventType == .touches else { return }
        setHighlighted((touches.first { bounds.contains($0.location(in: self)) }) != nil)
    }

    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        if activityIndicator == nil { activityIndicator = createActivityIndicator() }
        showSpinning()
    }
    func hideLoading() {
        guard let activity = activityIndicator else { return }
        self.setTitle(originalButtonText, for: .normal)
        activity.stopAnimating()
    }
}
