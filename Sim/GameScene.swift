//
//  GameScene.swift
//  Sim
//
//  Created by Arvid Boivie on 2018-03-06.
//  Copyright © 2018 Arvid Boivie. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var level: Level!
    
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 32.0
    
    let updateInterval: CFTimeInterval = 1.0
    var timeOfLastUpdate: CFTimeInterval = 0.0
    
    let gameLayer = SKNode()
    let tileLayer = SKNode()
    let entityLayer = SKNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(color: SKColor(red: 0.53, green: 0.91, blue: 0.31, alpha: 1), size: size)
        addChild(background)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileWidth * CGFloat(NumColumns) / 2,
            y: -TileHeight * CGFloat(NumRows) / 2)
        
        tileLayer.position = layerPosition
        entityLayer.position = layerPosition
        
        gameLayer.addChild(tileLayer)
        gameLayer.addChild(entityLayer)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (currentTime - timeOfLastUpdate < updateInterval) {
            return
        }
        
        level.updateEntities(forUpdate: currentTime)
        
        self.timeOfLastUpdate = currentTime
        
    }
    
    func addTiles(for tiles: Set<Tile>) {
        for tile in tiles {
            let sprite = SKLabelNode(text: tile.tileType.spriteName)
            sprite.position = pointFor(column: tile.column, row: tile.row)
            tileLayer.addChild(sprite)
            tile.sprite = sprite
        }
    }
    
    func addSprites(for entities: Set<Entity>) {
        for entity in entities {
            let sprite = SKLabelNode(text: entity.entityType.spriteName)
            sprite.position = pointFor(column: entity.column, row: entity.row)
            entityLayer.addChild(sprite)
            entity.sprite = sprite
        }
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*TileWidth + TileWidth/2,
            y: CGFloat(row)*TileHeight + TileHeight/2)
    }
}
