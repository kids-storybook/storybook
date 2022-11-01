//
//  AnimationPageSceneTutorial.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 10/10/22.
//

import Foundation
import SpriteKit
import UIKit

class AnimationPageSceneTutorial: GameScene {
    
    var story: Stories?
    var animateShape: [AnimatedShapes]?
    var activeShapes: [AnimatedShape] = []
    var totalStories: Int?
    var backgroundScene: SKSpriteNode!
    var box = SKSpriteNode(imageNamed: "square_3")
    var cone = SKSpriteNode(imageNamed: "triangle_1")
    var ball = SKSpriteNode(imageNamed: "circle_1")
    var bgOpacity = SKSpriteNode(imageNamed: "opacityBg")
    
    private func setupPlayer(){
        
        makeCharacterTutorial(imageName: self.story?.character)
        
        backgroundScene = SKSpriteNode(imageNamed: self.story?.background ?? "")
        backgroundScene.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundScene.zPosition = -10
        backgroundScene.size = self.frame.size
        
        addChild(backgroundScene)
        
        let rawLabels = story?.labels as? [String]
        
        if let labels = rawLabels {
            for (idx, label) in labels.enumerated() {
                let textScene = SKLabelNode(fontNamed: "Poppins-Black")
                textScene.text = label
                textScene.fontSize = 50
                textScene.fontColor = SKColor.white
                textScene.position = CGPoint(x: 0, y: Int(frame.height)/3-idx*60)
                textScene.zPosition = 100
                textScene.addStroke(color: textBorder, width: 7.0)
                addChild(textScene)
            }
        }
        
        bgOpacity.position = CGPoint(x: 0, y: 0)
        bgOpacity.size = CGSize(width: frame.width, height: frame.width)
        bgOpacity.zPosition = 13
        bgOpacity.alpha = 0
        
        box.animateUpDown(start: 3.0)
        cone.animateUpDown(start: 7.5)
        ball.animateUpDown(start: 12.0)
        bgOpacity.fadeInOut(start: 3.0)
        
        addChild(bgOpacity)

    }
    
    func setupAnimatedShapes() {
        //Create shapes
        
        for (idx, shape) in (animateShape ?? []).enumerated() {
            let activeShape = AnimatedShape(imageName: shape.shapeImage ?? "")
            if let spriteComponent = activeShape.component(ofType: SpriteComponent.self) {
                spriteComponent.node.position = CGPoint(x: shape.xCoordinateShape, y: shape.yCoordinateShape)
                spriteComponent.node.setScale(0.55)
                spriteComponent.node.animateUpDown(start: TimeInterval((idx+1)*2 + (idx*2)))
                
            }
            activeShapes.append(activeShape)
            entityManager.add(activeShape)
            
            let label = SKLabelNode(text: shape.shapeImage ?? "")
            
            label.fontName = "Poppins-Bold"
            label.position = CGPoint(x: shape.xCoordinateFont, y: shape.yCoordinateFont)
            label.textFadeInOut(start: TimeInterval((idx+1)*2 + (idx*2)))
            label.zPosition = 15
            label.fontSize = 80
            label.fontColor = UIColor.red
            label.addStroke(color: .white, width: 5.0)
            label.alpha = 0
            
            addChild(label)
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Fetch Stories Model
        entityManager = EntityManager(scene: self)
        do {
            let fetchRequest = Stories.fetchRequest()
            let orderPredicate = NSPredicate(format: "order == 0")
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate_2")
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                challengeNamePredicate, orderPredicate
            ])
            fetchRequest.fetchLimit = 1
            story = try context.fetch(fetchRequest)[0]
            
            fetchRequest.predicate = NSPredicate(format: "challengeName == %@", (challengeName ?? "") + "_animate_2")
            
            totalStories = try context.count(for: fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        // Fetch AnimatedShapes Model
        do {
            let fetchRequest = AnimatedShapes.fetchRequest()
            let challengeNamePredicate = NSPredicate(format: "challengeName == %@", (challengeName ?? ""))
            fetchRequest.predicate = challengeNamePredicate
            
            animateShape = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
        
        self.setupPlayer()
        self.setupAnimatedShapes()
    }
    
    override func getNextScene() -> SKScene? {
        let scene = SKScene(fileNamed: "ShapeGameScene") as! ShapeGameScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func getPreviousScene() -> SKScene? {
        let scene = SKScene(fileNamed: "AnimationPageScene") as! AnimationPageScene
        scene.idxScene = self.idxScene
        scene.challengeName = self.challengeName
        scene.theme = self.theme
        return scene
    }
    
    override func exitScene() -> SKScene? {
        let scene = SKScene(fileNamed: "MapViewPageScene") as! MapViewPageScene
        scene.theme = self.theme
        return scene
    }
    
}
