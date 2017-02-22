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
    
    enum SoundType: Int{
        case background
        case step
        case bookcase
        case buttonON
        case buttonOFF
        case closet
        case door
        case log
        case trash
    }
    
    
    //Singleton deifnition
    static let shared = AudioManager()
    
    var bgAudio: AVAudioPlayer = try! AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "bg", ofType: "mp3")!)!)
    
//    var soundLibrary: [SoundType : AVAudioPlayer] = [
//        .background = ,
//        .step =       AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "step", ofType: "aac")!)!),
//        .bookcase =   AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "bookcase", ofType: "aac")!)!),
//        .buttonON =   AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "buttonON", ofType: "aac")!)!),
//        .buttonOFF =  AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "buttonOFF", ofType: "aac")!)!),
//        .closet =     AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "closet", ofType: "aac")!)!),
//        .door =       AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "door", ofType: "aac")!)!),
//        .log =        AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "log", ofType: "aac")!)!),
//        .trash =      AVAudioPlayer.init(contentsOf: URL.init(string: Bundle.main.path(forResource: "trash", ofType: "aac")!)!)]
//    
    
//    //Audio configs
//    var musicOn: Bool{
//        get{
//            if let musicSetting = UserDefaults.standard.object(forKey: "com.drawrr.drawrrapp.musicOn") as? Bool{
//                return musicSetting
//            }
//            else{
//                return true
//            }
//        }
//        set{
//            UserDefaults.standard.set(newValue, forKey: "com.drawrr.drawrrapp.musicOn")
//            DispatchQueue.global().async {
//                self.updateBGSound()
//            }
//        }
//    }
//    
//    var soundsOn: Bool{
//        get{
//            if let soundsSetting = UserDefaults.standard.object(forKey: "com.drawrr.drawrrapp.soundsOn") as? Bool{
//                return soundsSetting
//            }
//            else{
//                return true
//            }
//        }
//        set{
//            UserDefaults.standard.set(newValue, forKey: "com.drawrr.drawrrapp.soundsOn")
//        }
//    }
//    
//    var rumbleOn: Bool{
//        get{
//            if let rumbleSetting = UserDefaults.standard.object(forKey: "com.drawrr.drawrrapp.rumbleSetting") as? Bool{
//                return rumbleSetting
//            }
//            else{
//                return true
//            }
//        }
//        set{
//            UserDefaults.standard.set(newValue, forKey: "com.drawrr.drawrrapp.rumbleSetting")
//        }
//    }

    
    private override init(){
        super.init()
        
//        for file in currentFiles{
//            let currentSound = try! AVAudioPlayer.init(contentsOf: URL.init(string: file)!)
//            currentSound.numberOfLoops = 0
//            currentSound.volume = 0.4
//            
//            if currentSounds != nil{
//                currentSounds!.append(currentSound)
//            } else{
//                currentSounds = [AVAudioPlayer]()
//                currentSounds!.append(currentSound)
//            }
//        }
        
        updateBGSound()
    }

    
    func updateBGSound(){
//        if musicOn{
            bgAudio.numberOfLoops = -1
            bgAudio.volume = 0.03
            bgAudio.play()
    }

}
