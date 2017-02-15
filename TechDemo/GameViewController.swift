//
//  GameViewController.swift
//  TechDemo
//
//  Created by Bernardo Alecrim on 2/6/17.
//  Copyright © 2017 Bernardo Alecrim. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene: SKScene?
    
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
            addGestureRecognizerWithType(UIPressType.upArrow, selector: #selector(GameViewController.upArrow))
            addGestureRecognizerWithType(UIPressType.downArrow, selector: #selector(GameViewController.downArrow))
            addGestureRecognizerWithType(UIPressType.leftArrow, selector: #selector(GameViewController.leftArrow))
            addGestureRecognizerWithType(UIPressType.rightArrow, selector: #selector(GameViewController.rightArrow))
        }
    
        func eventoSwipes(){
            addSwipeGestureRecognizerWithType(.right, selector: #selector(GameViewController.swipedRight))
            addSwipeGestureRecognizerWithType(.left, selector: #selector(GameViewController.swipedLeft))
            addSwipeGestureRecognizerWithType(.up, selector: #selector(GameViewController.swipedUp))
            addSwipeGestureRecognizerWithType(.down, selector: #selector(GameViewController.swipedDown))
        }
    
        func eventoPress(){
            addGestureRecognizerWithType(UIPressType.select, selector: #selector(GameViewController.select as (GameViewController) -> () -> ()));
            addGestureRecognizerWithType(UIPressType.menu, selector: #selector(GameViewController.menu));
            addGestureRecognizerWithType(UIPressType.playPause, selector: #selector(GameViewController.playPause));
        }
    
    
        // MARK: Tap events
        func select(){
            print("select")
        }
    
        func playPause(){
            print("play")
        }
    
        func menu(){
            print("menu")
        }
    
        //Test Keyboard
    
        func upArrow(){
            print("up")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .up)

            }
        }
    
        func downArrow(){
            print("down")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .down)
            }
        }
    
        func leftArrow(){
            print("left")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .left)
            }

        }
    
        func rightArrow(){
            print("right")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .right)
            }
    
        }
    
        //Personagem Anda aqui
    
        func swipedRight() {
            print("right")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .right)
            }
        }
        
        func swipedLeft() {
            print("left")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .left)
            }
        }
        
        func swipedUp() {
            print("up")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .up)
                
            }

    
        }
        
        func swipedDown() {
            print("down")
            DispatchQueue.main.async {
                let gScene = self.scene as! GameScene
                gScene.moveTile(tile: gScene.character!, on: .down)
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
