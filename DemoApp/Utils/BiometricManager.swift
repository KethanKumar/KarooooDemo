//
//  BiometricManager.swift
//  DemoApp
//
//  Created by Kethan on 22/09/22.
//


import UIKit
import LocalAuthentication

protocol BioMetricStatusDelegate: AnyObject {
    func biometricAuthentication(isSuccessful: Bool)
}

class BiometricManager: NSObject, BioMetricStatusDelegate {
    // swiftlint:disable all
    static let main = BiometricManager()
    var authDelegate: BioMetricStatusDelegate?
    // swiftlint:enable all

    static func biometricType() -> LABiometryType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch authContext.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            default:
                return .none
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }

    private func deviceOwnerAuthenticate(_ completionHandler : @escaping (Bool) -> Void) {
        //Create Local Authentication Context
        let authenticationContext = LAContext()
        authenticationContext.localizedFallbackTitle = ""
        var error: NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            // swiftlint:disable all
            guard let _ = error else { return }
            // swiftlint:enable all
            self.passcodeAuthentication()
            return
        }
        authenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Scan biometrics to continue.", reply: { (success, _) -> Void in
            completionHandler(success)
        })
    }

    fileprivate func passcodeAuthentication() {
        //Create Local Authentication Context
        let authenticationContext = LAContext()
        let policy = LAPolicy.deviceOwnerAuthentication

        let localisedReason: String = "Please enter your device passcode to unlock biometry"
        authenticationContext.evaluatePolicy(policy, localizedReason: localisedReason) { (isSuccessful, _) in
            if isSuccessful {
                debugPrint("Unlocked")
            }
        }
    }

    func authenticate(delegate: BioMetricStatusDelegate) {
        self.deviceOwnerAuthenticate { [weak self] (success) in
            if success {
                self?.authDelegate = delegate
                self?.authDelegate?.biometricAuthentication(isSuccessful: success)
            } else {
                self?.authDelegate = delegate
                self?.authDelegate?.biometricAuthentication(isSuccessful: false)
            }
        }
    }

    func biometricAuthentication(isSuccessful: Bool) {
        self.removeView()
        if let delegate = self.authDelegate {
            delegate.biometricAuthentication(isSuccessful: isSuccessful)
        }
    }

    fileprivate func removeView() {
        for view in UIApplication.shared.keyWindow!.subviews where view.tag == 909786 {
            view.removeFromSuperview()
        }
    }
}
