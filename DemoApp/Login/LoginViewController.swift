//
//  LoginViewController.swift
//  DCU
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, ViewController {

    typealias ViewModel = LoginViewModel
    private var viewModel: LoginViewModel!

    @IBOutlet private weak var loginBtn: CustomButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var forgotPasswordBtn: UIButton!
    @IBOutlet private weak var emailTextField: CustomTextField!
    @IBOutlet private weak var passwordTextfield: CustomTextField!
    @IBOutlet private weak var faceIdLoginbtn: UIButton!
    private var sdkVC: UIViewController?
    func configure(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.clearFields()
        setUpNavigationStyle(with: .clear)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

}

private extension LoginViewController {

    func configure() {
        navigationItem.hidesBackButton = true
        view.reactive.tapGesture().bind(to: self) { me, _ in
            me.view.endEditing(true)
        }
        viewModel.canContinue.bind(to: loginBtn.reactive.isEnabled)
        viewModel.email.bidirectionalBind(to: emailTextField.reactive.text)
        viewModel.password.bidirectionalBind(to: passwordTextfield.reactive.text)
        viewModel.isPasswordInvalid.bind(to: passwordTextfield.isInvalid)
        viewModel.isEmailInvalid.bind(to: emailTextField.isInvalid)
        loginBtn.reactive.controlEvents(.touchUpInside).bind(to: self) { me, _ in
            me.view.endEditing(true)
            me.viewModel.onLogin()
        }
        registerButton.reactive.controlEvents(.touchUpInside).bind(to: self) { me, _ in
            me.viewModel.onTapregister()
        }
        faceIdLoginbtn.reactive.controlEvents(.touchUpInside).bind(to: self) { me, _ in
            me.view.endEditing(true)
            me.viewModel.loginWithfaceId()
        }
        forgotPasswordBtn.reactive.controlEvents(.touchUpInside).bind(to: self) { me, _ in
            me.view.endEditing(true)
            me.viewModel.onForgotPassword()
        }
        viewModel.isLoading.bind(to: self) { me,val in
            if val {
                me.loginBtn.showLoading()
            } else {
                me.loginBtn.hideLoading()
            }
        }
        viewModel.errorToDisplay.bind(to: self) { me, err in
            guard let error = err else { return }
            me.showErrorAlertView(error: error)
        }
        loginBtn.imageView?.contentMode = .scaleAspectFit
        loginBtn.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
    }

}


extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == passwordTextfield {
            KeyboardHelper.sharedInstance.setActiveTextField(textField: textField)
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextfield   {
            KeyboardHelper.sharedInstance.clear()
        }
    }
}
