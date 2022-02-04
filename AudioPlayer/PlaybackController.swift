//
//  PlaybackController.swift
//  AudioPlayer
//
//  Created by Shahar Ben-Dor on 2/2/22.
//

import UIKit

class PlaybackController: UIViewController, TimeSliderDelegate {
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var albumImageBackgroundView: UIView!
    
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var songDetailsLabel: UILabel!
    @IBOutlet private weak var previousSongButton: UIButton!
    @IBOutlet private weak var playPauseButton: UIButton!
    @IBOutlet private weak var nextSongButton: UIButton!
    @IBOutlet private weak var timeSlider: TimeSlider!
    
    private var musicQueue = [Song]()
    private var currentSongIndex = 0
    private let audioPlayer = AudioPlayer()
    private var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.spacing = view.bounds.height/32
        
        albumImageView.layer.cornerRadius = 16
        albumImageBackgroundView.layer.shadowOpacity = 0.15
        albumImageBackgroundView.layer.shadowRadius = 15
        albumImageBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        musicQueue = [
            Song(
                title: "Reminiscence",
                albumTitle: "As the Years Go By - EP",
                artist: "Johannes Bornlöf",
                albumImage: UIImage(named: "Gradient 1"),
                fileURL: Bundle.main.url(forResource: "Johannes Bornlöf - Reminiscence", withExtension: "mp3")!
            ),
            Song(
                title: "In My Place",
                albumTitle: "A Rush of Blood to the Head",
                artist: "Coldplay",
                albumImage: UIImage(named: "Gradient 2"),
                fileURL: Bundle.main.url(forResource: "Coldplay - In My Place", withExtension: "m4a")!
            ),
            Song(
                title: "Takeaway (ft. Lennon Stella)",
                albumTitle: "World War Joy",
                artist: "The Chainsmokers",
                albumImage: UIImage(named: "Gradient 3"),
                fileURL: Bundle.main.url(forResource: "The Chainsmokers - Takeaway (ft. Lennon Stella)", withExtension: "mp3")!
            )
        ]
        
        audioPlayer.setSong(musicQueue[0])
        updateSongDetails()
        
        playPauseButton.setImage(UIImage(named: "Play Icon"), for: .normal)
        playPauseButton.setImage(UIImage(named: "Pause Icon"), for: .selected)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        displayLink?.add(to: .main, forMode: .default)
        
        timeSlider.delegate = self
    }

    @IBAction func didTapPreviousSongButton(_ sender: UIButton) {
        currentSongIndex = max(currentSongIndex - 1, 0)
        audioPlayer.setSong(musicQueue[currentSongIndex])
        audioPlayer.play()
        updateSongDetails()
    }
    
    @IBAction func didTapPlayPauseButton(_ sender: UIButton) {
        playPauseButton.isSelected = !playPauseButton.isSelected
        
        if playPauseButton.isSelected {
            audioPlayer.play()
        } else {
            audioPlayer.pause()
        }
    }
    
    @IBAction func didTapNextSongButton(_ sender: UIButton) {
        currentSongIndex = min(currentSongIndex + 1, musicQueue.count - 1)
        audioPlayer.setSong(musicQueue[currentSongIndex])
        audioPlayer.play()
        updateSongDetails()
    }
    
    private func updateSongDetails() {
        let currentSong = musicQueue[currentSongIndex]
        
        songTitleLabel.text = currentSong.title
        songDetailsLabel.text = currentSong.songDetailsString
        albumImageView.image = currentSong.albumImage
        timeSlider.mediaDuration = currentSong.duration
    }
    
    @objc func updateTime() {
        let currentTime = audioPlayer.currentTime
        let progress = currentTime/musicQueue[currentSongIndex].duration
        
        timeSlider.setProgress(to: progress)
    }
    
    func timeSliderDidEndSliding(_ timeSlider: TimeSlider, with progress: CGFloat) {
        audioPlayer.currentTime = progress * musicQueue[currentSongIndex].duration
    }
    
}




