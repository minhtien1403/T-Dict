//
//  SpeechServices.swift
//  T-Dict
//
//  Created by Tiến on 4/5/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import AVKit
import Then

struct SpeechServices {
    
    static let shared = SpeechServices()
    let synthesizer = AVSpeechSynthesizer()
    
    private init() {}
    
    func startReading(text: String, speed: Float) {
        stopReading()
        let utterance = AVSpeechUtterance(string: text).then {
            $0.voice =  AVSpeechSynthesisVoice(language: "en-GB")
            $0.rate = speed
        }
        synthesizer.speak(utterance)
    }
    
    func stopReading() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
