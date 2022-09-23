//
//  AlertViewModel.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
//

import UIKit
import Bond

class AlertViewModel {
    private(set) var notificationMessage = Observable<String?>("")
    private(set) var notificationTitle = Observable<String?>("")
    private(set) var textColor = Observable<UIColor?>(.white)

    init(alertTitle: String, alertMessage: String) {
        self.notificationTitle.value = alertTitle
        self.notificationMessage.value = alertMessage
        self.textColor.value = .white
      }
}
