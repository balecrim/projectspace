//
//  GameViewController.swift
//  TechDemo-iOS
//
//  Created by Bernardo Alecrim on 2/16/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: SKScene?
    var character: SKCharacterNode?
    
    #if os(iOS)
        override var prefersStatusBarHidden: Bool{
            get{ return true }
        }
    #endif
    
    // Press Type
    func addGestureRecognizerWithType(_ pressType : UIPressType, selector : Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tapGestureRecognizer.allowedPressTypes = [NSNumber(value: pressType.rawValue as Int)];
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Swipes
    func addSwipeGestureRecognizerWithType(_ direction : UISwipeGestureRecognizerDirection, selector : Selector) {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: selector)
        swipeGestureRecognizer.direction = direction
        view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    func eventoKeyboard(){
        addGestureRecognizerWithType(UIPressType.upArrow, selector: #selector(self.up))
        addGestureRecognizerWithType(UIPressType.downArrow, selector: #selector(self.down))
        addGestureRecognizerWithType(UIPressType.leftArrow, selector: #selector(self.left))
        addGestureRecognizerWithType(UIPressType.rightArrow, selector: #selector(self.right))
    }
    
    func eventoSwipes(){
        addSwipeGestureRecognizerWithType(.right, selector: #selector(self.right))
        addSwipeGestureRecognizerWithType(.left, selector: #selector(self.left))
        addSwipeGestureRecognizerWithType(.up, selector: #selector(self.up))
        addSwipeGestureRecognizerWithType(.down, selector: #selector(self.down))
    }
    
    func eventoPress(){
        addGestureRecognizerWithType(UIPressType.select, selector: #selector(self.selectButton))
        addGestureRecognizerWithType(UIPressType.menu, selector: #selector(self.menu))
        addGestureRecognizerWithType(UIPressType.playPause, selector: #selector(self.playPause))
        
    }
    
    @IBAction func selectPressed(_ sender: Any) {
        let gScene = self.scene as! GameScene
        if let character = gScene.character{
            gScene.characterSelect(near: character)
        }

    }
    
    // MARK: Tap events
    func selectButton(){
        print("select")
    }
    
    func playPause(){
        print("play")
    }
    
    func menu(){
        print("menu")
    }

    
    func up(){
        move(on: .up)
    }
    
    func down(){
        move(on: .down)
    }
    
    func left(){
        move(on: .left)
    }
    
    func right(){
        move(on: .right)
    }
    
    
    func move(on direction: MovementDirection){
        
        DispatchQueue.main.async {
            let gScene = self.scene as! GameScene
            gScene.moveTile(tile: gScene.character!, on: direction)
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventoPress()
        eventoSwipes()
        eventoKeyboard()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene.init(size: view.frame.size)
            self.scene = scene
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            print(scene.camera!)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}