//
//  AlertViewModel.swift
//  Medsi
//
//  Created by Kethan Kumar on 02/02/2022.
//  Copyright © 2022 ODF. All rights reserved.
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
