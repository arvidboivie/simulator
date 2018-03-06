//
//  Tiles.swift
//  Sim
//
//  Created by Arvid Boivie on 2018-03-06.
//  Copyright © 2018 Arvid Boivie. All rights reserved.
//

import SpriteKit

enum TileType: Int {
    case unknown = 0, empty, rock
    
    var spriteName: String {
        let spriteNames = [
            " "
        ]
        
        return spriteNames[rawValue - 1]
    }
    
    static func random() -> TileType {
        return TileType(rawValue: Int(arc4random_uniform(1)) + 1)!
    }
}

class Tile: Hashable {
    var column: Int
    var row: Int
    let tileType: TileType
    var sprite: SKLabelNode?
    var hashValue: Int {
        return row*10 + column
    }
    
    init(column: Int, row: Int, tileType: TileType) {
        self.column = column
        self.row = row
        self.tileType = tileType
    }
}

func ==(lhs: Tile, rhs: Tile) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.tileType == rhs.tileType
}

