//
//  AudioManager.swift
//  DrawIt
//
//  Created by Bernardo Alecrim on 12/2/16.
//  Copyright © 2016 Bernardo Alecrim. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager: NSObject{
    
    enum SoundType: String{
        case background = "bg"
        case step = "step"
        case bookcase = "book"
        case buttonON = "btnON"
        case buttonOFF = "btnOFF"
        case closet = "closet"
        case door = "door"
        case log = "log"
        case trash = "trash"
        
        static let all = [background,
                          step,
                          bookcase,
                          buttonON,
                          buttonOFF,
                          closet,
                          door,
                          log,
                          trash]
    }
    
    
    //Singleton deifnition
    static let shared = AudioManager()
    
    var players: [SoundType : AVAudioPlayer?] = [:]
    
    private override init(){
        super.init()
        
        for sound in SoundType.all{
            let file: String
            
            if sound == .background{
                file = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")!
            } else{
                file = Bundle.main.path(forResource: sound.rawValue, ofType: "m4a")!

            }
            
            let soundPlayer = try! AVAudioPlayer.init(contentsOf: URL.init(string: file)!)
            players[sound] = soundPlayer
        }

        loop(sound: .background)
    }

    
    func loop(sound: SoundType){
        
        if let player = players[sound]{
            player?.numberOfLoops = -1
            
            #if os(tvOS)
                player?.volume = 1
            #elseif os(iOS)
                player?.volume = 0.03
            #endif

            player?.play()
        }

    }
    
    func play(sound: SoundType){
        if let player = players[sound]{
            
            #if os(tvOS)
                player?.volume = 1
            #elseif os(iOS)
                player?.volume = 0.1
            #endif
            
            player?.play()
        }

    }

}
