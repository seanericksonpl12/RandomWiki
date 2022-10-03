//
//  SpeechHandler.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/29/22.
//

import SwiftUI
import AVFoundation
import MediaPlayer

open class SpeechHandler: NSObject {
    
    var synth: AVSpeechSynthesizer = AVSpeechSynthesizer()
    var completionHandler: SimpleClosure
    var startAction: SimpleClosure
    
    override init() {
        self.completionHandler = {}
        self.startAction = {}
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
                                                            mode: .voicePrompt,
                                                            options: [.mixWithOthers, .allowAirPlay])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch { print(error) }
        super.init()
        synth.delegate = self
    }
}

// MARK: - Public functions
extension SpeechHandler {
    
    func speak(line: String) {
        let utterance = AVSpeechUtterance(string: line)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.pitchMultiplier = 1.0
        utterance.rate = 0.5
        synth.delegate = self
        synth.speak(utterance)
    }
    
    func backgroundSpeak(line: String) {
        speak(line: line)
        do {
            guard let path = Bundle.main.path(forResource: "silence", ofType: "mp3") else { return }
            if #available(iOS 16.0, *) {
                let url = URL(filePath: path)
                let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                player.prepareToPlay()
                player.play()
                player.stop()
            }
        } catch { print(error) }
    }
}

// MARK: - Delegate Functions
extension SpeechHandler: AVSpeechSynthesizerDelegate {
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completionHandler()
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        startAction()
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        completionHandler()
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        completionHandler()
    }
    
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        startAction()
    }
}
