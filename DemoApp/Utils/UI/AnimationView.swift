//
//  AnimationView.swift
//  DemoApp
//
//  Created by Kethan on 23/09/22.
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



    func animateImage(name: String, playMode: LottieLoopMode = .playOnce, completion: ((Bool) -> Void)?) {
        playAnimation(animationName: name, loopMode: playMode, completion: completion)
    }
}
