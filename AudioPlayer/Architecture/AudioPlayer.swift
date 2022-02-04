//
//  AudioPlayer.swift
//  AudioPlayer
//
//  Created by Shahar Ben-Dor on 2/3/22.
//

import Foundation
import AVFAudio

class AudioPlayer {
    
    private var audioPlayer: AVAudioPlayer?
    private var _currentSong: Song?
    var currentSong: Song? {
        get {
            return _currentSong
        }
    }
    
    var currentTime: TimeInterval {
        get {
            return audioPlayer?.currentTime ?? 0
        }
        
        set {
            audioPlayer?.currentTime = newValue
        }
    }
    
    init () {}
    
    func setSong(_ song: Song?) {
        audioPlayer?.stop()

        if let song = song {
            audioPlayer = try! AVAudioPlayer(contentsOf: song.fileURL)
        } else {
            audioPlayer = nil
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
}
