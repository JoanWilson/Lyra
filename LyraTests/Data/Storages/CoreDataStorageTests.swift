//
//  CoreDataStorageTests.swift
//  LyraTests
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import XCTest
import CoreData
import Lyra

final class CoreDataStorageTests: XCTestCase {

    var sut: CoreDataStorage! = nil

    override func setUp() {
        let container = CoreDataPersistentContainer(inMemory: true)
        sut = CoreDataStorage(container: container)
    }

    override func tearDown() {
        sut = nil
    }

    func test_createGameState_MustReturnNotNil() throws {
        let gameState = GameStateEntity(currentLevel: 0, creationDate: Date(), runes: [])
        let hasSaved = sut.createGameState(with: gameState)
        XCTAssertEqual(hasSaved, gameState)
    }

    func test_createGameState_MustReturnNil_WithGameStateNil() throws {
        let gameState: GameStateEntity? = nil
        let hasSaved = sut.createGameState(with: gameState)
        XCTAssertEqual(hasSaved, gameState)
    }

    func test_removeGameState_MustReturnTrue() throws {
        let gameState = GameStateEntity(currentLevel: 0, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameState)
        let hasRemoved = sut.removeGameState(with: gameState)
        XCTAssertEqual(hasRemoved, true)
    }

    func test_removeGameState_MustReturnFalse() throws {
        let gameStateInserted = GameStateEntity(currentLevel: 0, creationDate: Date(), runes: [])
        let gameStateNonexistent = GameStateEntity(currentLevel: 10, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameStateInserted)
        let hasRemoved = sut.removeGameState(with: gameStateNonexistent)
        XCTAssertEqual(hasRemoved, false)
    }

    func test_updateGameState_MustReturnEqualToInsertedObject() throws {
        XCTFail()
    }

    func test_updateGameState_MustReturnNil() throws {

    }

    func test_addRune_MustReturnEqualToCreatedRune() throws {
        
    }

    func test_addRune_MustReturnNil() throws {

    }

    func test_removeRune_MustReturnTrue() throws {

    }

    func test_removeRune_MustReturnFalse() throws {

    }

    func test_updateRune_MustReturnEqualToInsertedObject() throws {

    }

    func test_updateRune_MustReturnNil() throws {

    }




}

class MockPersistentContainer {

    lazy var container: NSPersistentContainer = {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            let container = NSPersistentContainer(name: "StateDatabase")
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()

}
