//
//  Song.swift
//  AudioPlayer
//
//  Created by Shahar Ben-Dor on 2/3/22.
//

import Foundation
import UIKit
import AVFoundation

public class Song {
    
    let title: String
    let albumTitle: String
    let artist: String
    let albumImage: UIImage?
    let fileURL: URL
    let duration: TimeInterval
    
    var songDetailsString: String {
        get {
            return "\(artist) • \(albumTitle)"
        }
    }
    
    init(title: String, albumTitle: String, artist: String, albumImage: UIImage?, fileURL: URL) {
        self.title = title
        self.albumTitle = albumTitle
        self.artist = artist
        self.albumImage = albumImage
        self.fileURL = fileURL
        
        let audioFile = try! AVAudioFile(forReading: fileURL)
        let samplingRate = audioFile.fileFormat.sampleRate
        let numberOfSamples = audioFile.length
        let duration = Double(numberOfSamples)/samplingRate
        self.duration = duration
    }
    
}
