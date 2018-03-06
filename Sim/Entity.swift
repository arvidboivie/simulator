//
//  Entity.swift
//  Sim
//
//  Created by Arvid Boivie on 2018-03-06.
//  Copyright © 2018 Arvid Boivie. All rights reserved.
//

import SpriteKit

enum EntityType: Int {
    case unknown = 0, wolf, sheep
    
    var spriteName: String {
        let spriteNames = [
            "🐺",
            "🐑"
        ]
        
        return spriteNames[rawValue - 1]
    }
    
    static var name: String {
        return "entity"
    }
    
    static func random() -> EntityType {
        return EntityType(rawValue: Int(arc4random_uniform(2)) + 1)!
    }
}

class Entity: Hashable {
    var column: Int
    var row: Int
    let entityType: EntityType
    var sprite: SKLabelNode?
    var hashValue: Int {
        return row*10 + column
    }
    
    init(column: Int, row: Int, entityType: EntityType) {
        self.column = column
        self.row = row
        self.entityType = entityType
    }
    
    func updateMe(forUpdate currentTime: CFTimeInterval) {
        let randomX = Int(arc4random_uniform(3)) - 1
        let randomY = Int(arc4random_uniform(3)) - 1
        
        column = column + randomX
        row = row + randomY
        
        let moveAction = SKAction.move(to: pointFor(column: column, row: row), duration: 0.7)
        sprite?.run(moveAction);
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*32 + 32/2,
            y: CGFloat(row)*32 + 32/2)
    }
}

func ==(lhs: Entity, rhs: Entity) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.entityType == rhs.entityType
}
