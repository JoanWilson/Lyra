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
        let gameState = GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
        let hasSaved = sut.createGameState(with: gameState)
        XCTAssertEqual(hasSaved, gameState)
    }

    func test_createGameState_MustReturnNil_WithGameStateNil() throws {
        let gameState: GameStateEntity? = nil
        let hasSaved = sut.createGameState(with: gameState)
        XCTAssertEqual(hasSaved, gameState)
    }

    func test_removeGameState_MustReturnTrue() throws {
        let gameState = GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameState)
        let hasRemoved = sut.removeGameState(with: gameState)
        XCTAssertEqual(hasRemoved, true)
    }

    func test_removeGameState_MustReturnFalse() throws {
        let gameStateInserted = GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
        let gameStateNonexistent = GameStateEntity(id: UUID(), currentLevel: 10, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameStateInserted)
        let hasRemoved = sut.removeGameState(with: gameStateNonexistent)
        XCTAssertEqual(hasRemoved, false)
    }

    func test_getGameStateByUUID_MustReturnCorrectGameStateEntity() throws {
        let gameStateEntity = GameStateEntity(id: UUID(), currentLevel: 2, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameStateEntity)
        let gameStateFetched = sut.getGameStateByUUID(gameStateEntity.id)
        let convertedGameState = sut.container.convertGameStateCoreDataToEntity(gameState: gameStateFetched)
        XCTAssertEqual(gameStateEntity, convertedGameState)
    }

    func test_getGameStateByUUID_MustReturnNil_WithNotCreatedObject() throws {
        let gameStateEntity = GameStateEntity(id: UUID(), currentLevel: 2, creationDate: Date(), runes: [])
        let gameStateFetched = sut.getGameStateByUUID(gameStateEntity.id)
        XCTAssertNil(gameStateFetched)
    }

    func test_getAllGameStates_MustReturnAllInsertedStates() {
        var gameStateArray = [GameStateEntity]()
        let gameStateEntity = GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
        let gameStateEntity2 = GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
        gameStateArray.append(gameStateEntity)
        gameStateArray.append(gameStateEntity2)

        for entity in gameStateArray {
            _ = sut.createGameState(with: entity)
        }

        let fetchedArray = sut.getAllGameStates()
        XCTAssertEqual(fetchedArray, gameStateArray)
    }

    func test_updateGameState_MustReturnEqualToInsertedObject() throws {
        var gameState = GameStateEntity(id: UUID(), currentLevel: 5, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameState)
        gameState.currentLevel += 1
        gameState.runes.append(RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0))
        let updatedState = sut.updateGameState(gameState, uuid: gameState.id)
        XCTAssertEqual(updatedState, gameState)
    }

    func test_updateGameState_MustReturnNil() throws {
        let gameState = GameStateEntity(id: UUID(), currentLevel: 5, creationDate: Date(), runes: [])
        _ = sut.createGameState(with: gameState)
        let gameStateFake = GameStateEntity(id: UUID(), currentLevel: 2, creationDate: Date(), runes: [])

        let updatedState = sut.updateGameState(gameStateFake, uuid: gameState.id)
        XCTAssertNil(updatedState)
    }

    func test_createdRune_MustReturnEqualToCreatedRune() throws {
        let rune = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        let hasSaved = sut.createRune(with: rune)
        XCTAssertEqual(hasSaved, rune)
    }

    func test_createRune_MustReturnNil() throws {
        let rune: RuneEntity? = nil
        let hasSaved = sut.createRune(with: rune)
        XCTAssertEqual(hasSaved, rune)
    }

    func test_removeRune_MustReturnTrue() throws {
        let rune = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        _ = sut.createRune(with: rune)
        let hasRemoved = sut.removeRune(with: rune)
        XCTAssertEqual(hasRemoved, true)
    }

    func test_removeRune_MustReturnFalse() throws {
        let rune = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        let hasRemoved = sut.removeRune(with: rune)
        XCTAssertEqual(hasRemoved, false)
    }

    func test_getRuneByUUID_MustReturnCorrectRuneEntity() throws {
        let runeEntity = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        _ = sut.createRune(with: runeEntity)
        let runeFetched = sut.getRuneByUUID(runeEntity.id)
        XCTAssertEqual(runeEntity, runeFetched)
    }

    func test_getRuneByUUID_MustReturnNil_WithNotCreatedRune() throws {
        let runeEntity = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        let runeFetched = sut.getRuneByUUID(runeEntity.id)
        XCTAssertNil(runeFetched)
    }

    func test_getAllRunes_MustReturnAllInsertedRunes() throws {
        var runeArray = [RuneEntity]()
        let runeEntity = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        let runeEntity2 = RuneEntity(id: UUID(), name: "test2", effect: 1, orderId: 1)
        runeArray.append(runeEntity)
        runeArray.append(runeEntity2)

        for entity in runeArray {
            _ = sut.createRune(with: entity)
        }

        let fetchedArray = sut.getAllRunes()
        XCTAssertEqual(fetchedArray, runeArray)
    }

    func test_updateRune_MustReturnEqualToInsertedObject() throws {
        let rune = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        _ = sut.createRune(with: rune)
        let runeFake = RuneEntity(id: UUID(), name: "fake", effect: 10, orderId: 0)

        let updatedRune = sut.updateRune(with: runeFake)
        XCTAssertNil(updatedRune)
    }

    func test_updateRune_MustReturnNil() throws {
        var rune = RuneEntity(id: UUID(), name: "test", effect: 0, orderId: 0)
        _ = sut.createRune(with: rune)
        rune.name = "changed"
        rune.effect = 2

        let updatedRune = sut.updateRune(with: rune)
        XCTAssertEqual(updatedRune, rune)
    }

}
