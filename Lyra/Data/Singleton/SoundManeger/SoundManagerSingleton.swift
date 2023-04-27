//
//  SoundManagerSingleton.swift
//  Lyra
//
//  Created by Luiz Sena on 26/04/23.
//

import Foundation
import AVKit

class SoundManager {

    static let instance = SoundManager()
    static let effectSoundInstance = SoundManager()

    var player: AVAudioPlayer?

    func playSound(with name: String) {

        guard let url = Bundle.main.url(
            forResource: name, withExtension: "m4a"
        ) else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }

    }

    func playForever(with name: String) {

        guard let url = Bundle.main.url(
            forResource: name, withExtension: "m4a"
        ) else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }

    }

    func stop() {
        player?.stop()
    }

    private init(player: AVAudioPlayer? = nil) {
        self.player = player
    }
}
