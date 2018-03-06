//
//  Level.swift
//  Sim
//
//  Created by Arvid Boivie on 2018-03-06.
//  Copyright © 2018 Arvid Boivie. All rights reserved.
//

import Foundation

let NumColumns = 30
let NumRows = 20

class Level {
    private var entities = [Entity]()
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)
    
    func setUp() -> Set<Tile> {
        return createTiles();
    }
    
    func spawn() -> Set<Entity> {
        return createInitialEntities()
    }
    
    func updateEntities(forUpdate currentTime: CFTimeInterval) {
        for entity in entities {
            entity.updateMe(forUpdate: currentTime)
        }
    }
    
    private func createTiles() -> Set<Tile> {
        var set = Set<Tile>()
        
        // 1
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                
                // 2
                let tileType = TileType.random()
                
                // 3
                let tile = Tile(column: column, row: row, tileType: tileType)
                tiles[column, row] = tile
                
                // 4
                set.insert(tile)
            }
        }
        return set
    }
    
    private func createInitialEntities() -> Set<Entity> {
        var set = Set<Entity>()
        
        // 1
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if (tiles[column, row]?.tileType == TileType.empty) {
                    let random = Int(arc4random_uniform(3))
                    
                    // A one in three chance to spawn
                    if (random == 0) {
                        // 2
                        let entityType = EntityType.random()
                        
                        // 3
                        let entity = Entity(column: column, row: row, entityType: entityType)
                        entities.append(entity)
                        
                        // 4
                        set.insert(entity)
                    }
                }
            }
        }
        return set
    }
}
