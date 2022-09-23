//
//  AnimationView.swift
//  Oyster-Native-App
//
//  Created by Emmanuel Casañas Cruz on 01/09/20.
//  Copyright © 2020 Oyster. All rights reserved.
//

import Foundation
import Lottie

private extension AnimationView {

    func playAnimation(animationName: String, loopMode: LottieLoopMode = .loop, completion: LottieCompletionBlock? = nil) {
        animation = Animation.named(animationName)
        self.loopMode = loopMode
        play(completion: completion)
    }
}

extension AnimationView {

   func animateLoading() {
       playAnimation(animationName: "spinner")
   }

    func animateLogo(completion: ((Bool) -> Void)?) {
        playAnimation(animationName: "logosplash", loopMode: .playOnce, completion: completion)
    }

    func animateLoadingButton() {
        playAnimation(animationName: "spinnerButton")
    }

    func animateImage(name: String, playMode: LottieLoopMode = .playOnce, completion: ((Bool) -> Void)?) {
        playAnimation(animationName: name, loopMode: playMode, completion: completion)
    }
}
