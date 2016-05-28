//
//  AudioManager.swift
//  RetroSkate
//
//  Created by Eric Internicola on 5/28/16.
//  Copyright © 2016 Eric Internicola. All rights reserved.
//

import SpriteKit
import AVFoundation

class AudioManager {
    static let sharedManager = AudioManager()

    var musicPlayer: AVAudioPlayer?

}

// MARK: - API

extension AudioManager {

    func playLevelMusic() {
        guard let levelMusicURL = NSBundle.mainBundle().URLForResource("musicMain", withExtension: "wav") else {
            print("Couldn't get Main Music URL")
            return
        }

        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: levelMusicURL)
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.prepareToPlay()
            musicPlayer?.play()
        } catch let error as NSError {
            print(error, "Error trying to create player: \(error.localizedDescription)")
        }
    }

    func stopLevelMusic() {
        guard let musicPlayer = musicPlayer else {
            return
        }
        musicPlayer.stop()
    }

}
