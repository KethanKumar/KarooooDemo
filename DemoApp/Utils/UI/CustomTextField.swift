//
//  DCUTextField.swift
//  DemoApp
//
//  Created by Kethan on 09/02/22.
//

import Foundation
import Bond
import UIKit

class CustomTextField: UITextField {
    var floatingLabel: UILabel = UILabel(frame: CGRect.zero)
    var floatingLabelHeight: CGFloat = 14
    var button = UIButton(type: .custom)
    var imageView = UIImageView(frame: CGRect.zero)
    var isInvalid = Observable(false)
    var isLocked = Observable(false)
    var errorMessageString = ""
    var hasFloatingLabel = false

    @IBInspectable
    var _placeholder: String?
    
    @IBInspectable
    var errorMessage: String = "" {
        didSet {
            self.errorMessageString = errorMessage
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 4.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var borderColor: UIColor = .darkGray {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    var floatingLabelColor: UIColor = UIColor.black {
        didSet {
            self.floatingLabel.textColor = floatingLabelColor
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    var floatingLabelBackground: UIColor = UIColor.white.withAlphaComponent(1) {
        didSet {
            self.floatingLabel.backgroundColor = self.floatingLabelBackground
            self.setNeedsDisplay()
        }
    }
    // swiftlint:disable all
    @IBInspectable
    var floatingLabelFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet {
            self.floatingLabel.font = self.floatingLabelFont
            self.font = self.floatingLabelFont
            self.tintColor = .blue
            self.setNeedsDisplay()
        }
    }
    // swiftlint:enable all
    @IBInspectable
    var isPasswordField: Bool = false {
        didSet {
            if isPasswordField { addViewPasswordButton() }
        }
    }

    @IBInspectable
    var isPickerField: Bool = false {
        didSet {
            if isPickerField {
                addDisclosure()
            } else {
                removeErrorBadge()
            }
        }
    }

    @IBInspectable
    var isFieldLocked: Bool = false {
        didSet {
            isLocked.value = isFieldLocked
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._placeholder = (self._placeholder != nil) ? self._placeholder : placeholder
        placeholder = self._placeholder // Make sure the placeholder is shown
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        self.floatingLabel = UILabel(frame: CGRect.zero)
        self.addTarget(self, action: #selector(self.addFloatingLabel), for: .editingChanged)
        self.addTarget(self, action: #selector(self.removeFloatingLabel), for: .editingDidEnd)
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.tintColor = .blue
        configure()
    }

    // Add a floating label to the view on becoming first responder
    @objc func addFloatingLabel() {

        if !hasFloatingLabel {
            hasFloatingLabel = true
            self.floatingLabel.textColor = isInvalid.value ? .red : .blue
            self.floatingLabel.font = floatingLabelFont
            self.floatingLabel.text = isInvalid.value ? errorMessage : self._placeholder
            self.floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            self.floatingLabel.clipsToBounds = true


            self.floatingLabel.frame =  CGRect(x: 0, y: 0, width: bounds.size.width, height: self.floatingLabelHeight)
            floatingLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(self.floatingLabel)
            self.floatingLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
            UIView.animate(withDuration: 0.1) {
                self.floatingLabel.frame = CGRect(x: 0, y: 0, width: self.floatingLabel.frame.width + 4, height: self.floatingLabel.frame.height + 2)
            }
            self.placeholder = ""
        } else if self.text == "" && hasFloatingLabel {
            removeFloatingLabel()
        }
        self.setNeedsDisplay()
    }

    @objc func removeFloatingLabel() {
        hasFloatingLabel = false
        if self.text == "" {
            UIView.animate(withDuration: 0.85) {
                self.subviews.forEach { $0.removeFromSuperview() }
                self.setNeedsDisplay()
            }
            self.placeholder = self._placeholder
        }
        self.layer.borderColor = UIColor.black.cgColor
    }

    func addViewPasswordButton() {
        self.button.setImage(UIImage(named: "showPassword"), for: .normal)
        self.button.imageView?.contentMode = .scaleAspectFit
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        self.button.frame = CGRect(x: 0, y: 16, width: 20, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
    }

    func addErrorBadge() {
        self.button.setImage(UIImage(named: "errorAlert"), for: .normal)
        self.button.imageView?.contentMode = .scaleAspectFit
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        self.button.frame = CGRect(x: 0, y: 16, width: 20, height: 16)
        self.button.clipsToBounds = true
        self.rightView = self.button
        self.rightViewMode = .always
    }

    func removeErrorBadge() {
        if isPasswordField {
            if isSecureTextEntry {
                self.button.setImage(UIImage(named:  "showPassword"), for: .normal)
            } else {
                self.button.setImage(UIImage(named:  "hidePassword"), for: .normal)
            }
        } else {
            self.rightView = nil
            self.rightViewMode = .always
        }
    }

    func addImage(image: UIImage) {
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 20, y: 0, width: 20, height: 20)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true

        DispatchQueue.main.async {
            self.leftView = self.imageView
            self.leftViewMode = .always
        }
    }

    func addDisclosure() {
        self.imageView.image = #imageLiteral(resourceName: "downDisclosure")
        self.imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.imageView.translatesAutoresizingMaskIntoConstraints = true
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true

        DispatchQueue.main.async {
            self.rightView = self.imageView
            self.rightViewMode = .always
        }
    }

    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "showPassword"), for: .normal)
        } else {
            self.button.setImage(UIImage(named: "hidePassword"), for: .normal)
        }
    }
}

extension CustomTextField {
    func configure() {
        _ = isInvalid.observeNext { [weak self] _ in
            self?.adjustAppearence()
        }
        _ = reactive.controlEvents(.allEditingEvents).observeNext { [weak self] in
            self?.isInvalid.value = false
        }
        _ = isLocked.observeNext { [weak self] _ in
            self?.adjustAppearence()
        }
    }

    func adjustAppearence() {
        if isInvalid.value {
            self.floatingLabel.textColor = .red
            self.floatingLabel.text = errorMessageString
            self.addErrorBadge()
        } else {
            self.floatingLabel.textColor = .blue
            self.floatingLabel.text = _placeholder
            removeErrorBadge()
        }
        if isLocked.value {
            self.textColor = .lightGray
            self.isUserInteractionEnabled = false
        } else {
            self.textColor = floatingLabelColor
            self.isUserInteractionEnabled = true
        }
    }
}
