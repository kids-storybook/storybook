//
//  ThemeComponent.swift
//  Storybook
//
//  Created by zy on 04/10/22.
//

import Foundation
import SpriteKit
import GameplayKit

enum Theme: String {
    case theme1 = "zoo"
    case theme2 = "forest"
    case theme3 = "garden"
//    case theme4 = "empty card 2"
//    case theme5 = "empty card 3"
    
    static let allValues: [String] = [theme1.rawValue, theme2.rawValue, theme3.rawValue]
    static let allAssets: [String:[String:Any]] = [
        "zoo":["background":"mini zoo card", "startButton":"start button", "label":"mini zoo", "isActive": true],
        "forest":["background":"empty card", "startButton":"start button", "label":"mini zoo", "isActive": false],
        "garden":["background":"empty card 1", "startButton":"start button", "label":"mini zoo", "isActive": false],
//        "empty card 2":["background":"empty card 1", "startButton":"start button", "label":"mini zoo"],
//        "empty card 3":["background":"empty card 1", "startButton":"start button", "label":"mini zoo"]
    ]
}

class ThemeComponent: GKComponent {
    let theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

