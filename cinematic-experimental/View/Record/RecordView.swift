//
//  RecordView.swift
//  cinematic-experimental
//
//  Created by Caio Madeira on 09/11/21.
//

import UIKit
import AVFoundation

@objc public protocol ButtonPressedDelegate {
    @objc func recordButtonPressed() -> Void
    @objc func playButtonPressed() -> Void
}

class RecordView: UIView {
    
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var filename: String = "testAudioFile.m4a"
    let background = UIColor(hex: "#5b247a")
    
    private var cimaticView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.image = UIImage(systemName: "menu_icon")
        return view
    }()
    
    lazy var recordButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(recordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var playButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeView()
        setupConstraints()
        playButton.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeView() {
        self.backgroundColor = background
        self.recordButton.setTitle("Record", for: .normal)
        self.recordButton.backgroundColor = .red
        self.recordButton.layer.cornerRadius = 8
        self.recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.playButton.setTitle("Play", for: .normal)
        self.playButton.backgroundColor = .blue
        self.playButton.layer.cornerRadius = 8
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.addSubview(cimaticView)
        self.addSubview(recordButton)
        self.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            cimaticView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            cimaticView.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant: -500),
            cimaticView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant:  -16),
            cimaticView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            playButton.topAnchor.constraint(equalTo: self.cimaticView.bottomAnchor),
            playButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            playButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            recordButton.topAnchor.constraint(equalTo: self.cimaticView.bottomAnchor),
            recordButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

extension RecordView: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func setupDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func setupRecorder() {
        let file = setupDirectory().appendingPathComponent(filename)
        let recordDetails = [ AVFormatIDKey: kAudioFormatAppleLossless, AVEncoderBitRateKey: 320000, AVNumberOfChannelsKey: 2,
                   AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue, AVSampleRateKey: 44100.2] as [String:Any]
        
        do {
            recorder = try AVAudioRecorder(url: file, settings: recordDetails)
            recorder?.delegate = self
            recorder?.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let file = setupDirectory().appendingPathComponent(filename)
        do {
            player = try AVAudioPlayer(contentsOf: file)
            player?.delegate = self
            player?.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.setTitle("Play", for: .normal)
    }
    
}


extension RecordView: ButtonPressedDelegate {
    @objc func recordButtonPressed() {
        if recordButton.titleLabel?.text == "Record" {
            recorder?.record()
            recordButton.setTitle("Stop", for: .normal)
            playButton.isEnabled = false
        } else {
            recorder?.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = false
        }
    }
    
    @objc func playButtonPressed() {
        if recordButton.titleLabel?.text == "Record" {
            playButton.setTitle("Stop", for: .normal)
            recordButton.isEnabled = false
            setupPlayer()
            player?.play()
            
        } else {
            player?.stop()
            playButton.setTitle("Play", for: .normal)
            recordButton.isEnabled = false
        }
    }
}
