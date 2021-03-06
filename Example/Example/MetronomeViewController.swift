//
//  MetronomeViewController.swift
//  Example
//
//  Created by user on 2021/01/01.
//  Copyright © 2021 Gary Newby. All rights reserved.
//

import UIKit
import AVFoundation
class MetronomeViewController: UIViewController {

        @IBOutlet weak var tempoLabel: UILabel!
        @IBOutlet weak var tempoStepper: UIStepper!
        @IBOutlet weak var tempoSlider: UISlider!
        @IBOutlet weak var tsUpperLabel: UILabel!
        @IBOutlet weak var tsUpperStepper: UIStepper!
        @IBOutlet weak var tsLowerLabel: UILabel!
        @IBOutlet weak var tsLowerStepper: UIStepper!
        @IBOutlet weak var countLabel: UILabel!
        @IBOutlet weak var playButton: UIButton!
        
        var metronomeTimer: Timer!
        var metronomeIsOn = false
        var metronomeSoundPlayer: AVAudioPlayer!
        var metronomeAccentPlayer: AVAudioPlayer!
        var count: Int = 0 {
            didSet {
                if count == 0 {
                    countLabel.text = String(tsUpper)
                } else {
                    countLabel.text = String(count)
                }
            }
        }
        var tempo: TimeInterval = 60 {
            didSet {
                tempoLabel.text = String(format: "%.0f", tempo)
                tempoStepper.value = Double(tempo)
                tempoSlider.value = Float(tempo)
            }
        }
        var tsUpper: Int = 4 {
            didSet {
                tsUpperLabel.text = String(tsUpper)
                tsUpperStepper.value = Double(tsUpper)
            }
        }
        var tsLower: Int = 4 {
            didSet {
                tsLowerLabel.text = String(tsLower)
                tsLowerStepper.value = Double(tsLower)
            }
        }

        @IBAction func stepTempo(sender: UIStepper) {
            tempo = sender.value
            restartMetronome()
        }
        
        @IBAction func stepTsUpper(sender: UIStepper) {
            tsUpper = Int(sender.value)
            restartMetronome()
        }
        
        @IBAction func stepTsLower(sender: UIStepper) {
            tsLower = Int(sender.value)
            restartMetronome()
        }
        
        @IBAction func slideTempo(sender: UISlider) {
            tempo = Double(sender.value)
            restartMetronome()
        }

        @IBAction func toggleClick(sender: UIButton) {
            if metronomeIsOn {
                stopMetronome(sender: sender)
            } else {
                startMetronome(sender: sender)
            }
        }
        
        func stopMetronome(sender: UIButton) {
            metronomeIsOn = false
            metronomeTimer?.invalidate()
            count = 0
            sender.setTitle("Start", for: UIControl.State.normal)
        }
        
        func startMetronome(sender: UIButton) {
            metronomeIsOn = true
            sender.setTitle("Stop", for: UIControl.State.normal)
            let metronomeTimeInterval:TimeInterval = (240.0 / Double(tsLower)) / tempo
            metronomeTimer = Timer.scheduledTimer(timeInterval: metronomeTimeInterval, target: self, selector: #selector(playMetronomeSound), userInfo: nil, repeats: true)
            metronomeTimer?.fire()
        }

        @objc func playMetronomeSound() {
            count += 1
            if count == 1 {
                metronomeAccentPlayer.play()
            } else {
                metronomeSoundPlayer.play()
                if count == tsUpper {
                    count = 0
                }
            }
        }
        
        func restartMetronome() {
            if metronomeIsOn {
                stopMetronome(sender: playButton)
                startMetronome(sender: playButton)
            }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tempo = 120
            tsUpper = 4
            tsLower = 4
            
            let metronomeSoundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "snizzap1", ofType: "wav")!)
            let metronomeAccentURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "snizzap2", ofType: "wav")!)

            metronomeSoundPlayer = try? AVAudioPlayer(contentsOf: metronomeSoundURL as URL)
            metronomeAccentPlayer = try? AVAudioPlayer(contentsOf: metronomeAccentURL as URL)
            
            metronomeSoundPlayer.prepareToPlay()
            metronomeAccentPlayer.prepareToPlay()
        }
    }

